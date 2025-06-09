/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "./API";
type GeneratedMutation<InputType, OutputType> = string & {
  __generatedMutationInput: InputType;
  __generatedMutationOutput: OutputType;
};

export const createMyCats =
  /* GraphQL */ `mutation CreateMyCats($input: CreateMyCatsInput!) {
  createMyCats(input: $input) {
    id
    name
    __typename
  }
}
` as GeneratedMutation<
    APITypes.CreateMyCatsMutationVariables,
    APITypes.CreateMyCatsMutation
  >;
export const updateMyCats =
  /* GraphQL */ `mutation UpdateMyCats($input: UpdateMyCatsInput!) {
  updateMyCats(input: $input) {
    id
    name
    __typename
  }
}
` as GeneratedMutation<
    APITypes.UpdateMyCatsMutationVariables,
    APITypes.UpdateMyCatsMutation
  >;
export const deleteMyCats =
  /* GraphQL */ `mutation DeleteMyCats($input: DeleteMyCatsInput!) {
  deleteMyCats(input: $input) {
    id
    name
    __typename
  }
}
` as GeneratedMutation<
    APITypes.DeleteMyCatsMutationVariables,
    APITypes.DeleteMyCatsMutation
  >;
