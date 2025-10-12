import { User } from "@/types/user";

export declare namespace Tenant {
  export interface Type {
    id: number;
    name: string;
    users: User.Type[];
  }
}
