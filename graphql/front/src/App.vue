<script setup>
import * as mutations from "./graphql/mutations";
import * as queries from "./graphql/queries";
import { generateClient } from "aws-amplify/api";
import { onMounted, ref } from "vue";

const name = ref("");
const description = ref("");
const cats = ref([]);

const client = generateClient();

async function addCat() {
  if (!name.value || !description.value) return;
  const cat = { name: name.value, description: description.value };
  await client.graphql({
    query: mutations.createCat,
    variables: { input: cat },
  });
  name.value = "";
  description.value = "";
}

async function fetchCats() {
  const fetchedCats = await client.graphql({
    query: queries.listMyCats,
  });

  cats.value = fetchedCats.data.listMyCats.items;
}

onMounted(() => {
  fetchCats();
});
</script>
<template>
  <div id="app">
    <h1>Cat App</h1>
    <input type="text" v-model="name" placeholder="Cat name" />
    <input type="text" v-model="description" placeholder="Cat description" />
    <button v-on:click="addCat">Create Cat</button>

    <div v-for="item in cats" :key="item.id">
      <h3>{{ item.name }}</h3>
      <p>{{ item.description }}</p>
    </div>
  </div>
</template>
