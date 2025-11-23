import { Client } from "./client";
import { createCollection } from "./create-collection";
import { detectText } from "./detect-text";

export const Rekognition = {
  get client() {
    return Client;
  },
  createCollection,
  detectText,
} as const;
