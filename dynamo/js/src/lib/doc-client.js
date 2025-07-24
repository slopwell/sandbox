import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient } from "@aws-sdk/lib-dynamodb";

// dynamo local用の設定
const config = {
  region: "ap-northeast-1",
  endpoint: "http://localhost:8000",
  credentials: {
    accessKeyId: "dummy",
    secretAccessKey: "dummy",
  },
};

const client = new DynamoDBClient(config);
const docClient = DynamoDBDocumentClient.from(client);

export { docClient };
