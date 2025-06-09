import { ApolloServer } from "@apollo/server";
import { startStandaloneServer } from "@apollo/server/standalone";
import { PrismaClient } from "@prisma/client";
import { readFileSync } from "fs";
import { Context } from "./types/core/core";
import { Site } from "./types/link/link";

const prisma = new PrismaClient();

const resolvers = {
  Query: {
    info: () => "Hackernews Clone",
  },

  Mutation: {
    post: (parent: any, args: Site, context: Context): Promise<Site> => {
      const newbie = context.prisma.link.create({
        data: {
          description: args.description ?? "",
          url: args.url,
        },
      });
      return newbie;
    },
  },
};

// gqlファイルを読み込み
const typeDefs = readFileSync(`${__dirname}/schema/schema.gql`, "utf8");

const server = new ApolloServer({
  typeDefs,
  resolvers,
});

startStandaloneServer(server, {
  listen: { port: 4000 },
  context: async ({ req }) => ({
    ...req,
    prisma,
  }),
}).then(({ url }) => {
  console.log(`🚀  Server ready at: ${url}`);
});
