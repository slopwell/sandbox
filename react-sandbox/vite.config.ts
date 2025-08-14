import react from "@vitejs/plugin-react-swc";
import { resolve } from "path";
import { defineConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: [
      {
        find: /^#\/(.+)$/,
        replacement: resolve(__dirname, "src/types/$1"),
      },
      {
        find: /^~\/(.+)$/,
        replacement: resolve(__dirname, "src/lib/$1"),
      },
      {
        find: /^@\/(.+)$/,
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
