import esbuild from "esbuild";
import fs from "fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { spawnSync } from "node:child_process";

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
  await esbuild.build({
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

  const command = "terragrunt";
  const args = ["apply", "--auto-approve"];
  const cwd = srcDir;

  console.log(`command will run: ${command} ${args.join(" ")} @ ${cwd}`);

  const result = spawnSync(command, args, { cwd });

  const buffers = result.output.filter((it) => it != null);

  const lines = buffers.map((it) => it.toString("utf-8"));
  lines.forEach((it) => console.log(it));

  return lines.join("\n");
})(process.argv.slice(2));
