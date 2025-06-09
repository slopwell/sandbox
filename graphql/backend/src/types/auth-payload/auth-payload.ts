import type { User } from "../user/user";

export type AuthPayload = User & {
  token: string;
};
