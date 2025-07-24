import { GetCommand } from "@aws-sdk/lib-dynamodb";
import { docClient } from "./doc-client.js";

export const getCommand = async (artist, songTitle) => {
  const command = new GetCommand({
    TableName: "Music",
    Key: {
      Artist: artist,
      SongTitle: songTitle,
    },
  });

  const response = await docClient.send(command);
  return response.Item;
};
