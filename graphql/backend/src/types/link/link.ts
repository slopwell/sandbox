import type { User } from "../user/user";
import type { ID } from "../core/core";

export type Link = {
  id: ID;
  description?: string;
  url: string;
  postedBy?: User | null;
  postedById: ID | null;
};

export type Site = Pick<Link, "description" | "url">;
