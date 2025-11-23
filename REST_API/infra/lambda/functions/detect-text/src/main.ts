import type { Context } from "aws-lambda";
import { ResourceHandler } from "./request-handler/index";

export const main = async (event: any, context: Context) => {
  const { resource, method, body } = event;
  return ResourceHandler(resource, method, body);
};
