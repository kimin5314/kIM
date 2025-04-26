<template>
  <div class="flex flex-col h-screen">
    <!-- Top bar -->
    <header class="bg-blue-600 text-white text-center py-4 text-xl font-bold">
      Public Chat Room
      <div v-if="!connected" class="text-sm mt-1">(Connecting...)</div>
    </header>

    <!-- Messages list -->
    <main ref="chatContainer" class="flex-1 overflow-y-auto p-4 bg-gray-100">
      <div v-for="msg in messages" :key="msg.id" class="mb-3">
        <div class="font-semibold text-blue-700">{{ msg.sender }}</div>
        <div class="text-gray-800">{{ msg.content }}</div>
        <div class="text-xs text-gray-400">{{ formatTimestamp(msg.timestamp) }}</div>
      </div>
    </main>

    <!-- Input box -->
    <footer class="flex p-4 bg-white shadow">
      <input
        v-model="newMessage"
        @keyup.enter="sendMessage"
        class="flex-1 border border-gray-300 rounded px-3 py-2 mr-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
        placeholder="Type your message..."
      />
      <button
        @click="sendMessage"
        class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
      >
        Send
      </button>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { io } from 'socket.io-client'

// Setup WebSocket connection
const socket = io('http://localhost:5000')

const messages = ref([])
const newMessage = ref('')
const connected = ref(false)
const chatContainer = ref(null)

// Random guest name (for now)
const username = 'Guest' + Math.floor(Math.random() * 1000)

onMounted(() => {
  socket.on('connect', () => {
    connected.value = true
    console.log('Connected to server')
  })

  socket.on('disconnect', () => {
    connected.value = false
    console.log('Disconnected from server')
  })

  socket.on('message', (data) => {
    messages.value.push({
      id: Date.now() + Math.random(), // ensure unique ID
      sender: 'Anonymous',            // Assuming backend doesn't attach sender info
      content: data,
      timestamp: Date.now()
    })
    scrollToBottom()
  })
})

function sendMessage() {
  if (newMessage.value.trim()) {
    socket.send(`${username}: ${newMessage.value}`)
    newMessage.value = ''
  }
}

function scrollToBottom() {
  nextTick(() => {
    if (chatContainer.value) {
      chatContainer.value.scrollTop = chatContainer.value.scrollHeight
    }
  })
}

function formatTimestamp(ts) {
  const date = new Date(ts)
  return date.toLocaleTimeString()
}
</script>

<style scoped>
/* Optional: Smooth scroll */
main {
  scroll-behavior: smooth;
}
</style>
