import fs from "fs";
import esbuild from "esbuild";
import path from "node:path";
import { fileURLToPath } from "node:url";

export const __filename = fileURLToPath(import.meta.url);
export const __dirname = path.dirname(__filename);

// src/functions/${dirname} の文字列を引数に取り、引数のディレクトリからindex.tsを探索し、ESBuild でビルドし、./dist/functions/${dirname} に出力する
(async (dirname) => {
  console.log(dirname);
  const srcDir = path.resolve(__dirname, `../functions/${dirname}`);
  const distDir = path.resolve(__dirname, `../dist/functions/${dirname}`);
  const entryPoint = path.resolve(srcDir, "index.ts");
  const tsconfig = path.resolve(__dirname, "../tsconfig.json");

  // ディレクトリが存在しない場合は作成する
  if (!fs.existsSync(distDir)) {
    fs.mkdirSync(distDir, { recursive: true });
  }
  console.log("Build: ", entryPoint);

  // ESBuild でビルドする
  const res = await esbuild.build({
    entryPoints: [entryPoint],
    bundle: true,
    minify: true,
    platform: "node",
    target: "node18",
    outfile: path.resolve(distDir, "index.js"),
    // tsconfig,
    format: "cjs",
    external: ["aws-sdk"],
  });
  console.log("OK");
  return res.outputFiles[0].path;
})(process.argv.slice(2));
