const handleDogs = (method: string) => {
  switch (method) {
    case "GET": {
      return () => {
        return "GET /dogs";
      };
    }
    case "POST": {
      return () => {
        return "POST /dogs";
      };
    }
    default: {
      throw new Error(`Unknown method: ${method}`);
    }
  }
};

export const ResourceHandler = (resource: string, method: string) => {
  switch (resource) {
    case "dogs": {
      return handleDogs(method);
    }
    default: {
      throw new Error(`Unknown resource: ${resource}`);
    }
  }
};
