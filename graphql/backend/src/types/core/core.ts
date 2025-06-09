import type { PrismaClient } from "@prisma/client";

export type Context = {
  prisma: PrismaClient;
};

/** alias number */
export type ID = number;
