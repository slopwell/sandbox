import {
  CreateCollectionCommand,
  type CreateCollectionCommandInput,
  type CreateCollectionCommandOutput,
} from "@aws-sdk/client-rekognition";
import { Client } from "~/aws/rekognition/client";

/**
 * @param {string} CollectionId
 * @param {Record<string, string>} Tags
 * @returns {Promise<CreateCollectionCommandOutput>}
 */
export const createCollection = async (
  CollectionId: string,
  Tags?: Record<string, string>
): Promise<CreateCollectionCommandOutput> => {
  const input: CreateCollectionCommandInput = {
    CollectionId,
    Tags,
  };
  const command = new CreateCollectionCommand(input);

  const output = await Client.instance.send(command).catch((error) => {
    throw new Error(error);
  });

  console.assert(output.CollectionArn != null);
  return output;
};
