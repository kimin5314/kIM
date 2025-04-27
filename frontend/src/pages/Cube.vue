<script setup lang="ts">
import { TresCanvas } from '@tresjs/core';
import { OrbitControls } from '@tresjs/cientos';
</script>

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
