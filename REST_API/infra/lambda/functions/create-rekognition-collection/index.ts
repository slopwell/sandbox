import type { Context } from "aws-lambda";
import { Rekognition } from "~/aws/rekognition";

export async function handler(event: any, context: Context): Promise<any> {
  console.log("event: %j", event);
  const output = Rekognition.createCollection("slopwell-sandbox");
  console.log("output: %j", output);
  return output;
}
