import type { Context } from "../types/core/core";
import type { Link } from "../types/link/link";
import { AuthPayload } from "../types/auth-payload/auth-payload";
import { Converter } from "../types/user/converer";
import * as jwt from "jsonwebtoken";
import * as bcrypt from "bcryptjs";

const JWT_SECRET_KEY = "JWT_SECRET_KEY";

const signup = async (
  parent: any,
  args: any,
  context: Context
): Promise<AuthPayload> => {
  const password = await bcrypt.hash(args.password, 10);
  const _user = await context.prisma.user.create({
    data: {
      ...args,
      password,
    },
  });

  const user = Converter.marshall(_user);

  const token = jwt.sign({ userId: user.id }, JWT_SECRET_KEY);

  return {
    token,
    ...user,
  };
};

async function login(
  parent: any,
  args: any,
  context: Context
): Promise<AuthPayload> {
  const user = await context.prisma.user.findUnique({
    where: { email: args.email },
  });
  if (!user) {
    throw new Error("No such user found");
  }

  const valid = await bcrypt.compare(args.password, user.password ?? "");

  if (!valid) {
    throw new Error("Invalid password");
  }

  const token = jwt.sign({ userId: user.id }, JWT_SECRET_KEY);
  return {
    token,
    ...user,
  };
}

async function post(parent: any, args: any, context: Context): Promise<Link> {
  const newbie = await context.prisma.link.create({
    data: {
      description: args.description,
      url: args.url,
    },
  });
  return {
    ...newbie,
    url: newbie.url ?? "",
    description: newbie.description ?? "",
    postedById: newbie.postedById ?? -1,
  };
}
