import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  ScanCommand,
  type ScanCommandInput,
  type ScanCommandOutput,
} from "@aws-sdk/lib-dynamodb";
import { APIGatewayProxyResult } from "aws-lambda";

const client = new DynamoDBClient({ region: "ap-northeast-1" });
const docClient = DynamoDBDocumentClient.from(client);

export const handler = async (): Promise<APIGatewayProxyResult> => {
  // nameテーブルから全件取得するinputScanを作成
  const inputScan: ScanCommandInput = {
    TableName: "dogs",
  };

  const scanCommand = new ScanCommand(inputScan);
  const result: ScanCommandOutput = await docClient.send(scanCommand);

  const response: APIGatewayProxyResult = {
    statusCode: result.$metadata.httpStatusCode ?? 200,
    headers: {
      "Access-Control-Allow-Headers":
        "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
      "Access-Control-Allow-Methods": "GET,OPTIONS,POST,PUT",
      "Access-Control-Allow-Origin": " * ",
    },
    body: JSON.stringify(result.Items),
  };
  return response;
};
