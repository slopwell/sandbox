const crypto             = require("node:crypto");
const { faker }          = require("@faker-js/faker");
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const {
  DynamoDBDocumentClient,
  PutCommand,
} = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);


/**
 * ダミーの名前を10個生成し、PutItemの形式にまとめる
 * @returns {Record<string, any>} fake item
 */
const createFakeItem = () => {
  const item = [];
  for (let i = 0; i < 10; i++) {
    const id       = crypto.randomUUID().toString();
    const fakeName = faker.internet.userName();
    item.push({ id : id, name: fakeName });
  }
  return item;
};

(async () => {
  const fakeItem = createFakeItem();
  const putParam = {
    TableName: "names",
    Item: fakeItem,
  };
  // dynamoeDBにデータを投入する
  const command  = new PutCommand(putParam);
  const response = await docClient.send(command);
  return response;
})();