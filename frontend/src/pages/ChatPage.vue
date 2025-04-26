<template>
  <div>
    <h1>Chat Room</h1>
    <div v-for="msg in messages" :key="msg.id">{{ msg.content }}</div>
    <input v-model="newMessage" placeholder="Type a message..." />
    <button @click="sendMessage">Send</button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { io } from 'socket.io-client'

const socket = io('http://localhost:5000')

const messages = ref([])
const newMessage = ref('')

onMounted(() => {
  socket.on('message', (data) => {
    console.log('Received message:', data)
    messages.value.push({ id: Date.now(), content: data })
  })
})

function sendMessage() {
  if (newMessage.value.trim()) {
    console.log('Sending message:', newMessage.value)
    socket.send(newMessage.value)
    newMessage.value = ''
  }
}
</script>
