import type { Tenant } from "@/types/tenant";

const memo1 = {
  id: 1,
  title: "メモ1",
  content: "メモ1の内容",
};

const memo2 = {
  id: 2,
  title: "メモ2",
  content: "メモ2の内容",
};

const memo3 = {
  id: 3,
  title: "メモ3",
  content: "メモ3の内容",
};

const memo4 = {
  id: 4,
  title: "メモ4",
  content: "メモ4の内容",
};

export const tenant: Tenant = {
  id: 1,
  name: "テナント1",
  users: [
    {
      id: 1,
      name: "ユーザ1",
      memos: [memo1, memo2],
    },
    {
      id: 2,
      name: "ユーザ2",
      memos: [memo1, memo3, memo4],
    },
  ],
};
