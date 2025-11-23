import { S3Client, S3ClientConfig } from "@aws-sdk/client-s3";
import { AwsConfig } from "~/aws/core/aws-config";

let instance: S3Client;

export const Client = {
  get instance() {
    if (instance == null) {
      const config: S3ClientConfig = {
        ...AwsConfig.config,
      };
      if (process.env.AWS_S3_FORCE_PATH_STYLE === "true") {
        config.forcePathStyle = true;
      }
      instance = new S3Client(config);
    }
    return instance;
  },
};
