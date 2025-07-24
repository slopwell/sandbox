import { getCommand } from "./lib/get-command.js";
import { queryCommand } from "./lib/query-command.js";
import { PutItemCommand } from "./lib/put-item.js";
import { UpdateItemCommand } from "./lib/update-command.js";

const sendDocClientCommand = async (command) => {
  const response = await docClient.send(command);
  return response;
};

const main = async () => {
  console.log("------------------------");
  console.log("QueryCommand: 検索条件を指定してデータを取得");
  console.log("SELECT * FRONT Music Where Artist = 'No One You Know'");
  const queryCommand = new QueryCommand({
    TableName: "Music",
    KeyConditionExpression: "Artist = :artist",
    ExpressionAttributeValues: {
      ":artist": artist,
    },
    ConsistentRead: true,
  });
  const queryResult = await sendDocClientCommand(queryCommand);
  console.log(
    "QueryCommand Count: %s Result: %o",
    queryResult.length,
    queryResult
  );

  console.log("------------------------");
  console.log("GetCommand: 主キーを指定してデータを取得");
  console.log(
    "SELECT * FRONT Music Where Artist = 'No One You Know' AND SongTitle = 'Call Me Today'"
  );
  const getCommand = new GetCommand({
    TableName: "Music",
    Key: {
      Artist: "No One You Know",
      SongTitle: "Call Me Today",
    },
  });
  const getResult = await sendDocClientCommand(getCommand);
  console.log("GetCommand Result:", getResult);

  console.log("------------------------");
  console.log("PutItemCommand: データを追加");
  console.log(
    "INSERT INTO Music (Artist, SongTitle, AlbumTitle, Awards) VALUES ('No One You Know', 'New Song', 'New Album', 5)"
  );
  const item = {
    Artist: "No One You Know",
    SongTitle: "New Song",
    AlbumTitle: "New Album",
    Awards: 5,
  };
  const putCommand = new PutItemCommand({
    TableName: "Music",
    Item: item,
  });
  const putResult = await sendDocClientCommand(putCommand);

  console.log("------------------------");
  console.log("UpdateItemCommand: データを更新");
  console.log(
    "UPDATE Music SET Awards = 6 WHERE Artist = 'No One You Know' AND SongTitle = 'New Song'"
  );
  item.Awards = item.Awards + 1;
  const updateCommand = new UpdateCommand({
    TableName: "Music",
    Key: {
      Artist: item.Artist,
      SongTitle: item.SongTitle,
    },
    UpdateExpression: "set #albumTitle = :albumTitle, Awards = :awards",
    ExpressionAttributeNames: {
      "#albumTitle": "AlbumTitle",
    },
    ExpressionAttributeValues: {
      ":albumTitle": item.AlbumTitle,
      ":awards": item.Awards,
    },
    ReturnValues: "UPDATED_NEW",
  });
  //  Update はハッシュとソートキーを指定して更新しないといけない
  const updateResult = await sendDocClientCommand(updateCommand);

  console.log("------------------------");
  console.log("GetCommand: 更新後のデータを再度取得");
  console.log(
    "SELECT * FRONT Music Where Artist = 'No One You Know' AND SongTitle = 'New Song'"
  );
  const getUpdatedResultCommand = new GetCommand({
    TableName: "Music",
    Key: {
      Artist: item.Artist,
      SongTitle: item.SongTitle,
    },
  });
  const updatedGetResult = await sendDocClientCommand(getUpdateResultCommand);
  console.log("Updated GetCommand Result:", updatedGetResult);

  console.log("処理が完了しました。");
};

main();
