import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient } from "@aws-sdk/lib-dynamodb";
import { AwsConfig } from "~/aws/core/aws-config";

let document: DynamoDBDocumentClient;

export const Client = {
  get document() {
    if (document == null) {
      document = DynamoDBDocumentClient.from(
        new DynamoDBClient(AwsConfig.config),
        {
          marshallOptions: {
            convertEmptyValues: true,
            removeUndefinedValues: true,
          },
        }
      );
    }
    return document;
  },

  destroy() {
    if (document != null) {
      document.destroy();
    }
  },
} as const;
