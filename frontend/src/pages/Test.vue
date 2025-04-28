<!-- OneCube.vue -->
<template>
  <canvas ref="canvas"></canvas>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'

/* ────────── refs ────────── */
const canvas = ref<HTMLCanvasElement | null>(null)
let renderer : THREE.WebGLRenderer
let scene    : THREE.Scene
let camera   : THREE.PerspectiveCamera
let controls : OrbitControls
let cube     : THREE.Mesh

/* ────────── build once ────────── */
function init() {
  /* renderer / scene / camera */
  renderer = new THREE.WebGLRenderer({ canvas: canvas.value!, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(devicePixelRatio)

  scene = new THREE.Scene()
  scene.background = new THREE.Color(0xf0f0f0)

  camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 1, 1000)
  camera.position.set(4, 3, 5)
  camera.lookAt(0, 0, 0)

  /* orbit controller */
  controls = new OrbitControls(camera, renderer.domElement)
  controls.enableDamping = true

  /* a single coloured cube */
  const geom = new THREE.BoxGeometry(2, 2, 2)
  const mat  = new THREE.MeshNormalMaterial()
  cube = new THREE.Mesh(geom, mat)
  scene.add(cube)

  /* lights (optional with MeshNormalMaterial but handy if you switch) */
  scene.add(new THREE.AmbientLight(0xffffff, 0.8))

  /* resize */
  window.addEventListener('resize', () => {
    camera.aspect = innerWidth / innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize(innerWidth, innerHeight)
  })

  /* click handler */
  renderer.domElement.addEventListener('pointerup', onClick)

  /* render loop */
  const loop = () => {
    controls.update()
    renderer.render(scene, camera)
    requestAnimationFrame(loop)
  }
  requestAnimationFrame(loop)
}

/* ────────── rotate on click ────────── */
let busy = false               // avoid overlapping tweens

function onClick() {
  if (busy) return             // ignore rapid-fire clicks
  busy = true
  const start = cube.rotation.y
  const end   = start + Math.PI / 2      // +90 °
  const dur   = 300                      // ms
  let t0 = 0

  function animate(t: number) {
    if (!t0) t0 = t                      // set first-frame baseline
    const k = Math.min((t - t0) / dur, 1)
    cube.rotation.y = start + (end - start) * k
    if (k < 1) {
      requestAnimationFrame(animate)
    } else {
      cube.rotation.y = Math.round(cube.rotation.y / (Math.PI / 2)) * (Math.PI / 2) // snap
      busy = false
    }
  }
  requestAnimationFrame(animate)
}

/* ────────── vue lifecycle ────────── */
onMounted(init)

onBeforeUnmount(() => {
  renderer.dispose()
  controls.dispose()
})
</script>

<style scoped>
canvas {
  display: block;
  width: 100%;
  height: 100%;
}
html, body {
  height: 100%;
  margin: 0;
}
</style>

