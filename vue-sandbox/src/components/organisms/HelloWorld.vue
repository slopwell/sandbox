<script setup lang="ts">
defineProps<{ msg: string }>();
</script>

<template>
  <h1 class="marble">{{ msg }}</h1>
  <h1 class="outline">{{ msg }}</h1>
</template>

<style scoped>
/* 緑のマーブルにする */
.marble {
  background: radial-gradient(#42b883, #42b883 1em, #fff 1em, #fff);
  background-size: 2em 2em;
  background-position: 0 0;
  animation: marble 1s infinite linear;
}

/* 輪郭線だけにする */
.outline {
  -webkit-text-fill-color: transparent;
  -webkit-text-stroke-width: 2px;
  -webkit-text-stroke-color: #42b883;
}
</style>
