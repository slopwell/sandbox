import crypto from "node:crypto";

import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  PutCommand,
  TranslateConfig,
  type PutCommandInput,
  type PutCommandOutput,
} from "@aws-sdk/lib-dynamodb";
import type { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

const marshallOptions = {
  // Whether to automatically convert empty strings, blobs, and sets to `null`.
  convertEmptyValues: false, // false, by default.
  // Whether to remove undefined values while marshalling.
  removeUndefinedValues: true, // false, by default.
  // Whether to convert typeof object to map attribute.
  convertClassInstanceToMap: false, // false, by default.
};
const transrateConfig: TranslateConfig = {
  marshallOptions,
};

const client = new DynamoDBClient({ region: "ap-northeast-1" });
const docClient = DynamoDBDocumentClient.from(client, transrateConfig);

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  if (!event.body) {
    return {
      statusCode: 400,
      headers: {
        "Access-Control-Allow-Headers":
          "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "Access-Control-Allow-Methods": "'GET,OPTIONS,POST,PUT'",
        "Access-Control-Allow-Origin": " * ",
      },
      body: "name is not found in request data",
    };
  }

  const requestBody = JSON.parse(event.body);
  const inputName = requestBody.name ?? "EMPTY";

  const inputPut: PutCommandInput = {
    TableName: "dogs",
    Item: {
      id: crypto.randomUUID().toString(),
      name: inputName,
    },
  };
  const command = new PutCommand(inputPut);
  const result: PutCommandOutput = await docClient.send(command);

  // 面倒くさいから
  const response: APIGatewayProxyResult = {
    statusCode: result.$metadata.httpStatusCode ?? 200,
    headers: {
      "Access-Control-Allow-Headers":
        "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "Access-Control-Allow-Methods": "'GET,OPTIONS,POST,PUT'",
      "Access-Control-Allow-Origin": " * ",
    },
    body: "OK",
  };
  return response;
};
