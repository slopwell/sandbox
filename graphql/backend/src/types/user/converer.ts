import type { User } from "./user";
/**
 * @param user
 * @returns
 */
export const marshallUser = <T extends User>(user: T): User => {
  return {
    id: user.id || -1,
    name: user.name || "",
    email: user.email || "",
    password: user.password || "",
    links: user.links || [],
  };
};

export const Converter = {
  marshall: marshallUser,
};
