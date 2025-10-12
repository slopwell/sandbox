import type { Memo } from "@/types/memo";

export declare namespace User {
  export interface Type {
    id: number;
    name: string;
    memos: Memo.Type[];
  }
}
