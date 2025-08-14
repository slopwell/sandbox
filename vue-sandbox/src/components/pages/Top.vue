<script setup lang="ts">
import MemoTable from "#/organisms/MemoTable.vue";
import { ref } from "vue";
import { tenant } from "./data";

const tab = ref("one");

const defaultUser = ref(tenant.users[0]);
</script>

<template>
  <h1>{{ tenant.name }}</h1>
  <h2>現在のユーザ : {{ defaultUser.name }}</h2>
  <v-card>
    <v-tabs v-model="tab" bg-color="primary">
      <v-tab v-for="memo of defaultUser.memos" :value="memo">
        {{ memo.title }}
      </v-tab>
    </v-tabs>

    <v-card-text>
      <v-window v-model="tab">
        <v-window-item v-for="memo of defaultUser.memos" :value="memo">
          <MemoTable :memo="memo" />
        </v-window-item>
      </v-window>
    </v-card-text>
  </v-card>
</template>
