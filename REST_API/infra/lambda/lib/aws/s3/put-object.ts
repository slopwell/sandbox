import {
  PutObjectCommand,
  type PutObjectCommandInput,
  type PutObjectCommandOutput,
} from "@aws-sdk/client-s3";
import { Client } from "~/aws/s3/client";

/**
 * オブジェクトをアップロードする
 * @param {string} bucketName
 * @param {string} fname
 * @param {Buffer} body
 * @param {PutObjectOption} options
 * @returns {Promise<PutObjectCommandOutput>}
 */
export async function putObject(
  bucketName = "slopwell",
  fname: string,
  body: Buffer,
  options?: PutObjectOption
): Promise<PutObjectCommandOutput> {
  const input: PutObjectCommandInput = {
    Bucket: bucketName,
    Key: fname,
    Body: body,
    ...options,
  };

  const command = new PutObjectCommand(input);
  const output = await Client.instance.send(command).catch((error) => {
    throw new Error(error);
  });

  return output;
}

export declare type PutObjectOption = Omit<
  PutObjectCommandInput,
  "Bucket" | "Key" | "Body"
>;
