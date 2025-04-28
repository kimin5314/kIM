<template>
  <canvas ref="canvas"></canvas>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'

/* ───────────────── constants ───────────────── */
const N = 3, LEN = 30, GAP = 1, HALF = (N - 1) / 2

/* ───────────────── refs & scene objects ─────── */
const canvas   = ref<HTMLCanvasElement|null>(null)
let  renderer  : THREE.WebGLRenderer
let  scene     : THREE.Scene
let  camera    : THREE.PerspectiveCamera
let  controls  : OrbitControls
let  rafId     : number
const master   = new THREE.Group()        // all cubes live here permanently
const textures : THREE.Texture[][][] = [] // [face][row][col]

/* ───────────────── build cubes ──────────────── */
function buildCubes() {
  const hide = new THREE.MeshBasicMaterial({ color: 0x555555 })
  const loader = new THREE.TextureLoader()

  // load textures once
  for (let f=0; f<6; f++){
    const faceTex:THREE.Texture[][]=[]
    for (let r=0;r<N;r++){
      const rowTex:THREE.Texture[]=[]
      for (let c=0;c<N;c++){
        const url = new URL(`../assets/${f}_${r}_${c}.png`,import.meta.url).href
        rowTex.push(loader.load(url))
      }
      faceTex.push(rowTex)
    }
    textures.push(faceTex)
  }

  // create 27 cubes
  for(let z=0;z<N;z++)
    for(let y=0;y<N;y++)
      for(let x=0;x<N;x++){
        const g = new THREE.BoxGeometry(LEN, LEN, LEN)
        const mats = [
          x===N-1 ? new THREE.MeshBasicMaterial({map:textures[0][N-1-y][N-1-z]}) : hide, // +X
          x===0   ? new THREE.MeshBasicMaterial({map:textures[1][N-1-y][z]})     : hide, // –X
          y===N-1 ? new THREE.MeshBasicMaterial({map:textures[2][z][x]})         : hide, // +Y
          y===0   ? new THREE.MeshBasicMaterial({map:textures[3][N-1-z][x]})     : hide, // –Y
          z===N-1 ? new THREE.MeshBasicMaterial({map:textures[4][N-1-y][x]})     : hide, // +Z
          z===0   ? new THREE.MeshBasicMaterial({map:textures[5][N-1-y][N-1-x]}) : hide  // –Z
        ]
        const cube = new THREE.Mesh(g, mats)
        cube.position.set(
          (x-HALF)*(LEN+GAP),
          (y-HALF)*(LEN+GAP),
          (z-HALF)*(LEN+GAP)
        )
        cube.userData.grid = {x,y,z}        // ← save integer coords
        master.add(cube)
      }
}

/* ───────────────── slice rotation ───────────── */
let busy = false                           // block re-entry

function turnSlice(axis:'x'|'y'|'z', layer:number, dir=1) {
  if(busy) return
  busy = true

  const pivot = new THREE.Group()
  master.children
    .filter(c=>c.userData.grid[axis]===layer)
    .forEach(c=>pivot.add(c))
  master.add(pivot)                        // keep hierarchy simple

  const start = 0, end = dir*Math.PI/2, dur = 250
  let t0 = 0
  function anim(ts:number){
    if(!t0) t0=ts
    const k = Math.min((ts-t0)/dur,1)
    pivot.rotation[axis] = start + end*k
    if(k<1){ requestAnimationFrame(anim) }
    else {
      pivot.rotation[axis] =
        Math.round(pivot.rotation[axis]/(Math.PI/2))*(Math.PI/2)

      pivot.updateMatrixWorld()
      while (pivot.children.length) {
        const c = pivot.children[0] as THREE.Mesh
        c.applyMatrix4(pivot.matrix)
        master.add(c)

        const idx = worldPosToIndex(c.position)
        c.userData.grid = idx
      }
      master.remove(pivot)
      busy = false
    }
  }
  requestAnimationFrame(anim)
}

/* ───────────────── pointer helpers ─────────── */
const ray  = new THREE.Raycaster()
const mouse   = new THREE.Vector2()

const moveThreshold = 5 // px
let hit : THREE.Intersection | null = null
let hitPos :THREE.Vector2 = new THREE.Vector2()

function getHit(event:PointerEvent){
  const rect = renderer.domElement.getBoundingClientRect()
  mouse.x = ((event.clientX-rect.left)/rect.width)*2-1
  mouse.y = -((event.clientY-rect.top)/rect.height)*2+1
  ray.setFromCamera(mouse,camera)
  return ray.intersectObjects(master.children, false)[0] || null
}

function onPointerDown(e: PointerEvent){
  if(busy) return
  setInterval(()=>{},50)

  hit = getHit(e)
  if(!hit) return
  hitPos.set(e.clientX, e.clientY)
}

function onPointerUp(e: PointerEvent) {
  const curPos = new THREE.Vector2(e.clientX, e.clientY)
  if (hitPos.distanceTo(curPos) > moveThreshold) { hit = null; return }

  if (!hit || busy) return

  const nWorld = hit.face!.normal.clone()
      .applyMatrix3(new THREE.Matrix3().getNormalMatrix(hit.object.matrixWorld))
      .round()                                // exactly -1, 0, or +1

  let axis: 'x'|'y'|'z'
  let layer: number
  let dir: number                             // +1 CW, -1 CCW

  if      (nWorld.x ===  1) { axis='x'; layer = 2; dir =  1 }   // +X
  else if (nWorld.x === -1) { axis='x'; layer = 0; dir = -1 }   // –X
  else if (nWorld.y ===  1) { axis='y'; layer = 2; dir =  1 }   // +Y
  else if (nWorld.y === -1) { axis='y'; layer = 0; dir = -1 }   // –Y
  else if (nWorld.z ===  1) { axis='z'; layer = 2; dir =  1 }   // +Z
  else if (nWorld.z === -1) { axis='z'; layer = 0; dir = -1 }   // –Z
  else return                                                   // shouldn’t happen

  const g = hit.object.userData.grid            // {x,y,z} kept up-to-date
  layer = g[axis]                               // 0 | 1 | 2
  if (layer === 1) return                   // ignore middle slice

  const key = e.button
  if (key === 0) { dir = -dir }                // right-click reverses direction

  turnSlice(axis, layer, dir)
}

const STEP = LEN + GAP            // centre-to-centre distance between cubes

function worldPosToIndex(pos: THREE.Vector3): {x:number,y:number,z:number} {
  return {
    x: Math.round(pos.x / STEP + HALF),
    y: Math.round(pos.y / STEP + HALF),
    z: Math.round(pos.z / STEP + HALF),
  }
}


/* ───────────────── lifecycle ──────────────── */
onMounted(()=>{
  renderer = new THREE.WebGLRenderer({canvas:canvas.value!, antialias:true})
  renderer.setSize(innerWidth, innerHeight)
  renderer.setPixelRatio(devicePixelRatio)

  scene   = new THREE.Scene()
  scene.background = new THREE.Color(0xffffff)
  camera  = new THREE.PerspectiveCamera(70, innerWidth/innerHeight, 1, 1000)
  camera.position.set(160,160,160); camera.lookAt(0,0,0)

  controls = new OrbitControls(camera, renderer.domElement)
  controls.enableDamping = true

  scene.add(new THREE.AmbientLight(0xffffff, 0.8))
  scene.add(master)
  buildCubes()

  renderer.domElement.addEventListener('pointerdown', onPointerDown)
  renderer.domElement.addEventListener('pointerup', onPointerUp)
  window.addEventListener('resize', ()=>{
    camera.aspect = innerWidth/innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize(innerWidth, innerHeight)
  })

  const loop = ()=>{ rafId=requestAnimationFrame(loop); controls.update(); renderer.render(scene,camera) }
  loop()
})

onBeforeUnmount(()=>{
  cancelAnimationFrame(rafId)
  renderer.dispose()
  controls.dispose()
})
</script>
