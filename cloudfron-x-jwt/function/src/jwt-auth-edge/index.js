/**
 * Lambda@Edgeハンドラー
 * @param {Object} event - CloudFrontイベント
 * @param {Object} context - Lambda実行コンテキスト
 * @param {Function} callback - コールバック関数
 */
exports.handler = async (event, context, callback) => {
  const request = event.Records[0].cf.request;
  const headers = request.headers;

  console.log("Request URI:", request.uri);
  console.log("Request Headers:", JSON.stringify(headers));

  try {
    if (!headers.Authorization || headers.Authorization.length === 0) {
      console.log("No Authorization header found");
      return unauthorizedResponse("Authorization header is missing");
    }

    const token = headers.Authorization[0].value;

    // "Bearer "プレフィックスの確認と除去
    if (!token.startsWith("Bearer ")) {
      console.log("Invalid Authorization header format");
      return unauthorizedResponse("Invalid Authorization header format");
    }

    const jwtToken = token.substring(7); // "Bearer "を除去

    const isValid = await verifyJWT(jwtToken);

    if (!isValid) {
      console.log("JWT validation failed");
      return unauthorizedResponse("Invalid or expired token");
    }

    console.log("JWT validation successful");
    callback(null, request);
  } catch (error) {
    console.error("Error processing request:", error);
    return unauthorizedResponse("Internal server error");
  }
};

/**
 * 実運用では適切なJWT検証ライブラリを強く推奨
 * @param {string} token - JWTトークン
 */
async function verifyJWT(token) {
  try {
    // トークン構造チェック
    const parts = token.split(".");
    if (parts.length !== 3) {
      console.log("Invalid JWT structure");
      return false;
    }

    const base64 = parts[1].replace(/-/g, "+").replace(/_/g, "/");
    const payload = JSON.parse(Buffer.from(base64, "base64").toString());
    console.log("JWT Payload:", JSON.stringify(payload));

    if (!payload.exp) {
      console.log("Token has no expiration");
      return false;
    }

    const now = Math.floor(Date.now() / 1000);
    if (payload.exp < now) {
      console.log(`Token expired: exp=${payload.exp}, now=${now}`);
      return false;
    }

    if (payload.token_use !== "id") {
      console.log(`Invalid token_use: ${payload.token_use}`);
      return false;
    }

    console.log("Token validation successful");
    return true;
  } catch (error) {
    console.error("JWT verification error:", error);
    return false;
  }
}

/**
 * 401 Unauthorized
 */
function unauthorizedResponse(message) {
  return {
    status: "401",
    statusDescription: "Unauthorized",
    headers: {
      "content-type": [
        {
          key: "Content-Type",
          value: "application/json",
        },
      ],
      "www-authenticate": [
        {
          key: "WWW-Authenticate",
          value: 'Bearer realm="CloudFront"',
        },
      ],
    },
    body: JSON.stringify({
      error: "Unauthorized",
      message: message,
    }),
  };
}
