/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "./API";
type GeneratedSubscription<InputType, OutputType> = string & {
  __generatedSubscriptionInput: InputType;
  __generatedSubscriptionOutput: OutputType;
};

export const onCreateMyCats =
  /* GraphQL */ `subscription OnCreateMyCats($id: String, $name: String) {
  onCreateMyCats(id: $id, name: $name) {
    id
    name
    __typename
  }
}
` as GeneratedSubscription<
    APITypes.OnCreateMyCatsSubscriptionVariables,
    APITypes.OnCreateMyCatsSubscription
  >;
export const onUpdateMyCats =
  /* GraphQL */ `subscription OnUpdateMyCats($id: String, $name: String) {
  onUpdateMyCats(id: $id, name: $name) {
    id
    name
    __typename
  }
}
` as GeneratedSubscription<
    APITypes.OnUpdateMyCatsSubscriptionVariables,
    APITypes.OnUpdateMyCatsSubscription
  >;
export const onDeleteMyCats =
  /* GraphQL */ `subscription OnDeleteMyCats($id: String, $name: String) {
  onDeleteMyCats(id: $id, name: $name) {
    id
    name
    __typename
  }
}
` as GeneratedSubscription<
    APITypes.OnDeleteMyCatsSubscriptionVariables,
    APITypes.OnDeleteMyCatsSubscription
  >;
