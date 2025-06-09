import { Context } from "../types/core/core";
import type { Site } from "../types/link/link";

export const feed = (parent: any, args: Site, context: Context) => {
  const result = context.prisma.link.findMany();
  return result;
};
