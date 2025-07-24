import { PutCommand } from "@aws-sdk/lib-dynamodb";
import { docClient } from "./doc-client.js";

export const PutItemCommand = async (item) => {
  const command = new PutCommand({
    TableName: "Music",
    Item: item,
  });

  const response = await docClient.send(command);

  return response;
};
