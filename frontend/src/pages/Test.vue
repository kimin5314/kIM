<script setup lang="ts">
import { ref } from 'vue'
import * as THREE from 'three'
import { OrbitControls } from '@tresjs/cientos'
import { extend, TresCanvas } from '@tresjs/core'

extend({ OrbitControls })

/* texture for the +X face */
const texture = new THREE.TextureLoader().load(
  new URL('../assets/1_0_0.png', import.meta.url).href
)

/* build the six-material array once */
const cubeMats = ref<THREE.Material[]>([
  new THREE.MeshStandardMaterial({ map: texture }), // +X
  new THREE.MeshStandardMaterial({ color: 0xff0000 }), // –X
  new THREE.MeshStandardMaterial({ color: 0xff0000 }), // +Y
  new THREE.MeshStandardMaterial({ color: 0xff0000 }), // –Y
  new THREE.MeshStandardMaterial({ color: 0xff0000 }), // +Z
  new THREE.MeshStandardMaterial({ color: 0x00ff00 })  // –Z
])
</script>

<template>
  <TresCanvas window-size clear-color="#ffffff" :shadows="true">
    <TresPerspectiveCamera :position="[80, 80, 80]" />
    <OrbitControls />m
    <TresAxesHelper :args="[50]" />

    <!-- pass the whole array at once -->
    <TresMesh :material="cubeMats" cast-shadow>
      <TresBoxGeometry :args="[10, 10, 10]" />
    </TresMesh>

    <TresAmbientLight :args="[0xffffff, 1]" />
  </TresCanvas>
</template>

