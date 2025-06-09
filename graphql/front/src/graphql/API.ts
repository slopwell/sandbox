/* tslint:disable */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type CreateMyCatsInput = {
  id: string;
  name: string;
};

export type MyCats = {
  __typename: "MyCats";
  id: string;
  name: string;
};

export type UpdateMyCatsInput = {
  id: string;
  name: string;
};

export type DeleteMyCatsInput = {
  id: string;
  name: string;
};

export type TableMyCatsFilterInput = {
  id?: TableStringFilterInput | null;
  name?: TableStringFilterInput | null;
};

export type TableStringFilterInput = {
  ne?: string | null;
  eq?: string | null;
  le?: string | null;
  lt?: string | null;
  ge?: string | null;
  gt?: string | null;
  contains?: string | null;
  notContains?: string | null;
  between?: Array<string | null> | null;
  beginsWith?: string | null;
  attributeExists?: boolean | null;
  size?: ModelSizeInput | null;
};

export type ModelSizeInput = {
  ne?: number | null;
  eq?: number | null;
  le?: number | null;
  lt?: number | null;
  ge?: number | null;
  gt?: number | null;
  between?: Array<number | null> | null;
};

export type MyCatsConnection = {
  __typename: "MyCatsConnection";
  items?: Array<MyCats | null> | null;
  nextToken?: string | null;
};

export type CreateMyCatsMutationVariables = {
  input: CreateMyCatsInput;
};

export type CreateMyCatsMutation = {
  createMyCats?: {
    __typename: "MyCats";
    id: string;
    name: string;
  } | null;
};

export type UpdateMyCatsMutationVariables = {
  input: UpdateMyCatsInput;
};

export type UpdateMyCatsMutation = {
  updateMyCats?: {
    __typename: "MyCats";
    id: string;
    name: string;
  } | null;
};

export type DeleteMyCatsMutationVariables = {
  input: DeleteMyCatsInput;
};

export type DeleteMyCatsMutation = {
  deleteMyCats?: {
    __typename: "MyCats";
    id: string;
    name: string;
  } | null;
};

export type GetMyCatsQueryVariables = {
  id: string;
  name: string;
};

export type GetMyCatsQuery = {
  getMyCats?: {
    __typename: "MyCats";
    id: string;
    name: string;
  } | null;
};

export type ListMyCatsQueryVariables = {
  filter?: TableMyCatsFilterInput | null;
  limit?: number | null;
  nextToken?: string | null;
};

export type ListMyCatsQuery = {
  listMyCats?: {
    __typename: "MyCatsConnection";
    items?: Array<{
      __typename: "MyCats";
      id: string;
      name: string;
    } | null> | null;
    nextToken?: string | null;
  } | null;
};

export type OnCreateMyCatsSubscriptionVariables = {
  id?: string | null;
  name?: string | null;
};

export type OnCreateMyCatsSubscription = {
  onCreateMyCats?: {
    __typename: "MyCats";
    id: string;
    name: string;
  } | null;
};

export type OnUpdateMyCatsSubscriptionVariables = {
  id?: string | null;
  name?: string | null;
};

export type OnUpdateMyCatsSubscription = {
  onUpdateMyCats?: {
    __typename: "MyCats";
    id: string;
    name: string;
  } | null;
};

export type OnDeleteMyCatsSubscriptionVariables = {
  id?: string | null;
  name?: string | null;
};

export type OnDeleteMyCatsSubscription = {
  onDeleteMyCats?: {
    __typename: "MyCats";
    id: string;
    name: string;
  } | null;
};
