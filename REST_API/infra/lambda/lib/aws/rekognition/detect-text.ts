import { Client } from "~/aws/rekognition/client";
import {
  DetectTextCommand,
  type DetectTextCommandInput,
  type DetectTextCommandOutput,
} from "@aws-sdk/client-rekognition";

export const detectText = async (
  imageName: string
): Promise<DetectTextCommandOutput> => {
  const input: DetectTextCommandInput = {
    Image: {
      S3Object: {
        /**@REVIEW 気が向いたら環境変数にしよ */
        Bucket: "slopwell",
        Name: imageName,
      },
    },
  };
  const command = new DetectTextCommand(input);

  const output = await Client.instance.send(command).catch((error) => {
    throw new Error(error);
  });

  return output;
};
