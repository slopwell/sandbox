/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "./API";

type GeneratedQuery<InputType, OutputType> = string & {
  __generatedQueryInput: InputType;
  __generatedQueryOutput: OutputType;
};

export const getMyCats =
  /* GraphQL */ `query GetMyCats($id: String!, $name: String!) {
  getMyCats(id: $id, name: $name) {
    id
    name
    __typename
  }
}
` as GeneratedQuery<APITypes.GetMyCatsQueryVariables, APITypes.GetMyCatsQuery>;
export const listMyCats = /* GraphQL */ `query ListMyCats(
  $filter: TableMyCatsFilterInput
  $limit: Int
  $nextToken: String
) {
  listMyCats(filter: $filter, limit: $limit, nextToken: $nextToken) {
    items {
      id
      name
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListMyCatsQueryVariables,
  APITypes.ListMyCatsQuery
>;
