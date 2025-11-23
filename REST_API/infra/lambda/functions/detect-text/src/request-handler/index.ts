import { DetectTextCommandOutput } from "@aws-sdk/client-rekognition";
import { Rekognition } from "~/aws/rekognition";
import { S3 } from "~/aws/s3";

const handleRekognition = async (
  method: string,
  body: any
): Promise<DetectTextCommandOutput> => {
  switch (method) {
    case "GET": {
      const datetime = new Date().toISOString();
      const fname = `test-${datetime}.png`;
      const output = await S3.putObject("slopwell", fname, body);
      return await Rekognition.detectText(fname);
    }

    default: {
      throw new Error(`Unknown method: ${method}`);
    }
  }
};

export const ResourceHandler = (
  resource: string,
  method: string,
  body: any
) => {
  switch (resource) {
    case "rekognition/detecttext": {
      return handleRekognition(method, body);
    }
    default: {
      throw new Error(`Unknown resource: ${resource}`);
    }
  }
};
