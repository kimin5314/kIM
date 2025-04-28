<template>
  <TresCanvas window-size clear-color="#FFFFFF" :shadows="true">
    <TresPerspectiveCamera :position="[80, 80, 80]" />
    <OrbitControls />
    <TresAxesHelper :args="[50]" />
    <TresMesh :position="[-11, -11, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, -11, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, 0, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, 0, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, -11, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, 0, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, -11, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[11, 11, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[11, 11, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
       <TresMesh :position="[11, 0, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, 11, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[11, 0, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, 11, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, 0, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[11, -11, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[11, -11, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[11, 0, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[11, 11, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
       <TresMesh :position="[11, -11, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, 11, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, 11, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, -11, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, -11, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, 11, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[-11, 0, 11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, 11, -11]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#FF0000" />
    </TresMesh>
    <TresMesh :position="[0, 0, 0]" cast-shadow>
      <TresBoxGeometry :args="[10,10,10]" />
      <TresMeshToonMaterial color="#00FF00" />
    </TresMesh>
    <TresDirectionalLight :position="[0, 20, 40]" :intensity="1.2" cast-shadow />
  </TresCanvas>
</template>

<script setup lang="ts">
import { TresCanvas } from '@tresjs/core';
import { OrbitControls } from '@tresjs/cientos';

import { ref } from 'vue'
import { onMounted } from 'vue'

// x, y, z, -x, -y, -z correspond to 0,1,2,3,4,5
const pieces = ref<string[][]>([])

onMounted(() => {
  for (let i = 0; i < 6; i++) {
    const img = new Image()
    img.src = new URL(`../assets/imgs/${i}.jpg`, import.meta.url).href
    img.onload = () => {
      cutImageIntoN(img, i,3)
    }
  }
})


function cutImageIntoN(img: HTMLImageElement, idx: number, n:number) {
  const pieceWidth = img.width / n
  const pieceHeight = img.height / n

  const tempCanvas = document.createElement('canvas')
  const tempCtx = tempCanvas.getContext('2d')!

  tempCanvas.width = pieceWidth
  tempCanvas.height = pieceHeight

  for (let row = 0; row < n; row++) {
    for (let col = 0; col < n; col++) {
      tempCtx.clearRect(0, 0, pieceWidth, pieceHeight)
      tempCtx.drawImage(
        img,
        col * pieceWidth, row * pieceHeight,  // source x, y
        pieceWidth, pieceHeight,              // source width, height
        0, 0,                                 // destination x, y
        pieceWidth, pieceHeight               // destination width, height
      )
      const url = tempCanvas.toDataURL('image/png')
      if (!pieces.value[idx]) {
        pieces.value[idx] = []
      }
      pieces.value[idx][row * n + col] = url
    }
  }
}
</script>

<style>
html,
body {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
}
#app {
  height: 100%;
  width: 100%;
  background-color: #000;
}
</style>
