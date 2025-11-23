import { ApiGatewayResponse, type ApiGatewayRequest } from "~/model/apigateway";
import { deleteDevice } from "./list-dogs";
import { getDevice } from "./get-dog";
import { updateDevice } from "./post-dog";

export const handleMethod = async (
  request: ApiGatewayRequest
): Promise<ApiGatewayResponse> => {
  switch (request.method) {
    case "GET": {
      return getDevice(request);
    }
    case "PUT": {
      return updateDevice(request);
    }
    case "DELETE": {
      return deleteDevice(request);
    }
    default: {
      return;
    }
  }
};

export const DogResourceHandler = {
  execute: async (request: ApiGatewayRequest): Promise<ApiGatewayResponse> => {
    switch (request.resource) {
      case "dog": {
        return handleMethod(request);
      }
      default: {
        return "504 Resource not found";
      }
    }
  },
};
