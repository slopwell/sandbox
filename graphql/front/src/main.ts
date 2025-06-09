import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";
import { Amplify } from "aws-amplify";
import { config } from "./aws-exports";

Amplify.configure(config);

createApp(App).mount("#app");
