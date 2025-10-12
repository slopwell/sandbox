<script setup lang="ts">
import { PropType } from "vue";
import type { Memo } from "@/types/memo";

defineProps({
  memo: {
    type: Object as PropType<Memo.Type>,
    required: true,
  },
});
</script>

<template>
  <v-table>
    <thead>
      <tr>
        <th class="text-left">ID</th>
        <th class="text-left">Title</th>
        <th class="text-left">作成日</th>
        <th class="text-left">内容</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="key in memo" :key="key">
        <td>{{ key }}</td>
      </tr>
    </tbody>
  </v-table>
</template>
