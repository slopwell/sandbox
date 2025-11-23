import {
  QueryCommand,
  type QueryCommandInput,
  type QueryCommandOutput,
} from "@aws-sdk/lib-dynamodb";
import { Client } from "./client";

export declare type QueryInput = QueryCommandInput &
  Required<Pick<QueryCommandInput, "KeyConditionExpression">>;

/**
 * 指定条件に一致するItemを返す.
 */
export const query = async (input: QueryInput): Promise<QueryCommandOutput> => {
  const command = new QueryCommand(input);

  const result = await Client.document
    .send(command)
    .catch((error) => Promise.reject(error));

  return result;
};
