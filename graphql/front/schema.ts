import { Schema } from "@aws-amplify/datastore";

export const schema: Schema = {
  models: {},
  enums: {},
  nonModels: {
    MyCats: {
      name: "MyCats",
      fields: {
        id: {
          name: "id",
          isArray: false,
          type: "String",
          isRequired: true,
          attributes: [],
        },
        name: {
          name: "name",
          isArray: false,
          type: "String",
          isRequired: true,
          attributes: [],
        },
      },
    },
    MyCatsConnection: {
      name: "MyCatsConnection",
      fields: {
        items: {
          name: "items",
          isArray: true,
          type: {
            nonModel: "MyCats",
          },
          isRequired: false,
          attributes: [],
          isArrayNullable: true,
        },
        nextToken: {
          name: "nextToken",
          isArray: false,
          type: "String",
          isRequired: false,
          attributes: [],
        },
      },
    },
  },
  codegenVersion: "3.4.4",
  version: "15f60e40bd8078e5c0d1fe07c2d95b9a",
};
