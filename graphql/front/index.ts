import {
  ModelInit,
  MutableModel,
  PersistentModelConstructor,
} from "@aws-amplify/datastore";
import { initSchema } from "@aws-amplify/datastore";

import { schema } from "./schema";

type EagerMyCatsModel = {
  readonly id: string;
  readonly name: string;
};

type LazyMyCatsModel = {
  readonly id: string;
  readonly name: string;
};

export declare type MyCatsModel = LazyLoading extends LazyLoadingDisabled
  ? EagerMyCatsModel
  : LazyMyCatsModel;

export declare const MyCatsModel: new (
  init: ModelInit<MyCatsModel>
) => MyCatsModel;

type EagerMyCatsConnectionModel = {
  readonly items?: (MyCats | null)[] | null;
  readonly nextToken?: string | null;
};

type LazyMyCatsConnectionModel = {
  readonly items?: (MyCats | null)[] | null;
  readonly nextToken?: string | null;
};

export declare type MyCatsConnectionModel =
  LazyLoading extends LazyLoadingDisabled
    ? EagerMyCatsConnectionModel
    : LazyMyCatsConnectionModel;

export declare const MyCatsConnectionModel: new (
  init: ModelInit<MyCatsConnectionModel>
) => MyCatsConnectionModel;

const { MyCats, MyCatsConnection } = initSchema(schema) as {
  MyCats: PersistentModelConstructor<MyCatsModel>;
  MyCatsConnection: PersistentModelConstructor<MyCatsConnectionModel>;
};

export {};
