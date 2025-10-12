import { createApp } from "vue";
import "./style.css";
import { vuetify } from "@/plugin/vuetify/vuetify";
import App from "@/App.vue";

createApp(App).use(vuetify).mount("#app");
