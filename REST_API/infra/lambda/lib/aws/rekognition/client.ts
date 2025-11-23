import { RekognitionClient } from "@aws-sdk/client-rekognition";
import { AwsConfig } from "~/aws/core/aws-config";

let instance: RekognitionClient;

export const Client = {
  get instance() {
    if (instance == null) {
      instance = new RekognitionClient(AwsConfig.config);
    }
    return instance;
  },
};
