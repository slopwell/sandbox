import type { Context } from "aws-lambda";
import { main } from "./src/main";

export async function handler(event: any, context: Context): Promise<any> {
  console.log("event: %j", event);
  return main(event, context);
}
