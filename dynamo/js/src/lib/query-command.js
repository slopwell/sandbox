import { QueryCommand } from "@aws-sdk/lib-dynamodb";
import { docClient } from "./doc-client.js";

export const queryCommand = async (artist) => {
  const command = new QueryCommand({
    TableName: "Music",
    KeyConditionExpression: "Artist = :artist",
    ExpressionAttributeValues: {
      ":artist": artist,
    },
    ConsistentRead: true,
  });

  const response = await docClient.send(command);

  return response.Items;
};
