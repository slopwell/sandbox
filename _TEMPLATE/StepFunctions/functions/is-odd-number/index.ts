import type { Context as LambdaContext } from "aws-lambda";
import { main } from "./src/main";

export const handler = async (
  event: any,
  context: LambdaContext
): Promise<any> => {
  return main(event);
};
