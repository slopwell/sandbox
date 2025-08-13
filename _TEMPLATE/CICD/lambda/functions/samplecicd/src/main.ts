import type { APIGatewayProxyEvent, Context } from "aws-lambda";

declare type APIGatewayEvent = Partial<APIGatewayProxyEvent> &
  Pick<
    APIGatewayProxyEvent,
    "httpMethod" | "pathParameters" | "body" | "requestContext"
  >;

export async function main(
  event: APIGatewayEvent,
  context?: Context
): Promise<any> {
  return "OK";
}
