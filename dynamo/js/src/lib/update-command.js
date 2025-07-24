import { UpdateCommand } from "@aws-sdk/lib-dynamodb";
import { docClient } from "./doc-client.js";

export const UpdateItemCommand = async (artist, songTitle, updates) => {
  const command = new UpdateCommand({
    TableName: "Music",
    Key: {
      Artist: artist,
      SongTitle: songTitle,
    },
    UpdateExpression: "set #albumTitle = :albumTitle, Awards = :awards",
    ExpressionAttributeNames: {
      "#albumTitle": "AlbumTitle",
    },
    ExpressionAttributeValues: {
      ":albumTitle": updates.AlbumTitle,
      ":awards": updates.Awards,
    },
    ReturnValues: "UPDATED_NEW",
  });

  const response = await docClient.send(command);
  return response.Attributes;
}
