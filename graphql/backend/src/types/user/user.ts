import type { Link } from "../link/link";
import type { ID } from "../core/core";

export type User = {
  id: ID;
  name: string | null;
  password: string | null;
  email: string;
  links?: Array<Link>;
};
