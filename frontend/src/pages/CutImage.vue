<template>
  <TresCanvas window-size clear-color="#ffffff">
    <TresPerspectiveCamera :position="[100,100,100]" />
    <OrbitControls />
    <TresAxesHelper :args="[50]" />
    <TresAmbientLight :args="[0xffffff, 0.5]" />
    <primitive :object="globalGroup" />  
  </TresCanvas>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { OrbitControls } from '@tresjs/cientos'
import { extend, TresCanvas } from '@tresjs/core'
import * as THREE from 'three'

extend({ OrbitControls })

/* Constants */
const LEN = 20
const GAP = 2
const N = 3
const HALF = (N - 1) / 2

/* State */
const textures: THREE.Texture[][][] = []
const groups = ref<THREE.Group[]>([])

const globalGroup = new THREE.Group()

function buildCubes() {
  const loader = new THREE.TextureLoader()
  const hide = new THREE.MeshBasicMaterial({color: 0x555555})

  for (let face = 0; face < 6; face++) {
    const faceTextures: THREE.Texture[][] = []

    for (let row = 0; row < 3; row++) {
      const rowTextures: THREE.Texture[] = []
      for (let col = 0; col < 3; col++) {
        const fileName = `${1}_${row}_${col}.png`
        const filePath = new URL(`../assets/${fileName}`, import.meta.url).href
        const tex = loader.load(filePath)
        rowTextures.push(tex)
      }
      faceTextures.push(rowTextures)
    }
    textures.push(faceTextures)
  }

  for (let z = 0; z < N; z++) {
    for (let y = 0; y < N; y++) {
      for (let x = 0; x < N; x++) {
        const geom = new THREE.BoxGeometry(LEN, LEN, LEN)

        const materials: THREE.Material[] = [
          x ===  N-1 ? new THREE.MeshStandardMaterial({ map: textures[0][N-1-y][N-1-z] }) : hide, // +X
          x === 0 ? new THREE.MeshStandardMaterial({ map: textures[1][N-1-y][z] }) : hide, // -X
          y ===  N-1 ? new THREE.MeshStandardMaterial({ map: textures[2][z][x] }) : hide, // +Y
          y === 0 ? new THREE.MeshStandardMaterial({ map: textures[3][N-1-z][x] }) : hide, // -Y
          z ===  N-1 ? new THREE.MeshStandardMaterial({ map: textures[4][N-1-y][x] }) : hide, // +Z
          z === 0 ? new THREE.MeshStandardMaterial({ map: textures[5][N-1-y][N-1-x] }) : hide, // -Z
        ]

        const cube = new THREE.Mesh(geom, materials)
        cube.position.set(
          (x - HALF) * (LEN + GAP),
          (y - HALF) * (LEN + GAP),
          (z - HALF) * (LEN + GAP),
        )

        if (x === N-1) { // +X
          if (!groups.value[0]) {
            groups.value[0] = new THREE.Group()
          }
          groups.value[0].add(cube)
        }
        if (x === 0) { // -X
          if (!groups.value[1]) {
            groups.value[1] = new THREE.Group()
          }
          groups.value[1].add(cube)
        }
        if (y === N-1) { // +Y
          if (!groups.value[2]) {
            groups.value[2] = new THREE.Group()
          }
          groups.value[2].add(cube)
        }
        if (y === 0) { // -Y
          if (!groups.value[3]) {
            groups.value[3] = new THREE.Group()
          }
          groups.value[3].add(cube)
        }
        if (z === N-1) { // +Z
          if (!groups.value[4]) {
            groups.value[4] = new THREE.Group()
          }
          groups.value[4].add(cube)
        }
        if (z === 0) { // -Z
          if (!groups.value[5]) {
            groups.value[5] = new THREE.Group()
          }
          groups.value[5].add(cube)
        }

        globalGroup.add(cube)
      }
    }
  }
}

onMounted(() => {
  buildCubes()
})
</script>

<style scoped>
html, body, #app { height: 100%; margin: 0; }
</style>

