const {
  CognitoIdentityProviderClient,
  InitiateAuthCommand,
} = require("@aws-sdk/client-cognito-identity-provider");

const USER_POOL_ID = process.env.USER_POOL_ID;
const CLIENT_ID = process.env.USER_POOL_CLIENT_ID;
const REGION = process.env.REGION || "ap-northeast-1";

const cognitoClient = new CognitoIdentityProviderClient({ region: REGION });

exports.handler = async (event) => {
  console.log("Event:", JSON.stringify(event, null, 2));

  // CORSヘッダー
  const headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
      "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
    "Access-Control-Allow-Methods": "GET,OPTIONS,POST,PUT",
  };

  try {
    const body = JSON.parse(event.body || "{}");
    const { username, password } = body;

    if (!username || !password) {
      return {
        statusCode: 400,
        headers,
        body: JSON.stringify({
          error: "Bad Request",
          message: "username and password are required",
        }),
      };
    }

    // Cognito認証
    const authParams = {
      AuthFlow: "USER_PASSWORD_AUTH",
      ClientId: CLIENT_ID,
      AuthParameters: {
        USERNAME: username,
        PASSWORD: password,
      },
    };

    console.log("Initiating auth with Cognito...");
    const command = new InitiateAuthCommand(authParams);
    const response = await cognitoClient.send(command);

    if (!response.AuthenticationResult) {
      throw new Error("Authentication failed - no tokens returned");
    }

    const { AccessToken, IdToken, RefreshToken, ExpiresIn } =
      response.AuthenticationResult;

    console.log("Authentication successful");

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        message: "Authentication successful",
        tokens: {
          accessToken: AccessToken,
          idToken: IdToken,
          refreshToken: RefreshToken,
          expiresIn: ExpiresIn,
        },
        usage: {
          cloudfront:
            'Use the idToken in the Authorization header as "Bearer <token>"',
          apiGateway: "Use the accessToken for API Gateway endpoints",
        },
      }),
    };
  } catch (error) {
    console.error("Error:", error);

    // Cognitoエラーの処理
    let statusCode = 500;
    let message = "Internal server error";

    if (error.name === "NotAuthorizedException") {
      statusCode = 401;
      message = "Invalid username or password";
    } else if (error.name === "UserNotFoundException") {
      statusCode = 404;
      message = "User not found";
    } else if (error.name === "UserNotConfirmedException") {
      statusCode = 403;
      message = "User not confirmed";
    } else if (error.name === "PasswordResetRequiredException") {
      statusCode = 403;
      message = "Password reset required";
    }

    return {
      statusCode,
      headers,
      body: JSON.stringify({
        error: error.name || "Error",
        message: message,
        details: error.message,
      }),
    };
  }
};
