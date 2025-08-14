import { defineConfig } from "vite";
import { resolve } from "path";
import path from "node:path";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: [
      {
        find: /^@\/(.+)$/,
        replacement: resolve(__dirname, "src/$1"),
      },
      {
        find: /^~\/(.+)$/,
        replacement: resolve(__dirname, "src/lib/$1"),
      },
      {
        find: /^#\/(.+)$/,
        replacement: resolve(__dirname, "src/components/$1"),
      },
      {
        find: /^%\/(.+)$/,
        replacement: resolve(__dirname, "test/$1"),
      },
      // https://github.com/aws-amplify/amplify-js/issues/7499#issuecomment-804386820 fix:
      {
        find: "./runtimeConfig",
        replacement: "./runtimeConfig.browser",
      },
      // fix-end
    ],
  },
});
