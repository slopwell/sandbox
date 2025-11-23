const { CognitoJwtVerifier } = require("aws-jwt-verify");

// 環境変数から設定を取得
const REGION = process.env.AWS_REGION || "ap-northeast-1";
const USER_POOL_ID = process.env.USER_POOL_ID;
const CLIENT_ID = process.env.CLIENT_ID;

// CognitoJwtVerifierのインスタンスを作成（再利用のためグローバルスコープ）
const verifier = CognitoJwtVerifier.create({
  userPoolId: USER_POOL_ID,
  tokenUse: "id", // IDトークンを検証
  clientId: CLIENT_ID,
});

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
    // Authorizationヘッダーの取得（小文字対応）
    const authHeader = headers.authorization || headers.Authorization;

    if (!authHeader || authHeader.length === 0) {
      console.log("No Authorization header found");
      return unauthorizedResponse("Authorization header is missing");
    }

    const token = authHeader[0].value;

    // "Bearer "プレフィックスの確認と除去
    if (!token.startsWith("Bearer ")) {
      console.log("Invalid Authorization header format");
      return unauthorizedResponse("Invalid Authorization header format");
    }

    const jwtToken = token.substring(7); // "Bearer "を除去

    // CognitoJwtVerifierで検証
    const payload = await verifier.verify(jwtToken);

    console.log("JWT validation successful", {
      sub: payload.sub,
      email: payload.email,
      exp: payload.exp,
      token_use: payload.token_use,
    });

    // (オプション) Email検証チェック
    if (payload.email_verified === false) {
      console.log("Warning: Email not verified for user:", payload.email);
      // 必要に応じてコメントアウトを解除
      // return unauthorizedResponse("Email not verified");
    }

    // 検証成功: リクエストを通過させる
    callback(null, request);
  } catch (error) {
    console.error("JWT verification failed:", error.message);

    // エラーの種類に応じた詳細ログ
    if (error.name === "JwtExpiredError") {
      console.log("Token expired");
      return unauthorizedResponse("Token expired");
    } else if (error.name === "JwtInvalidClaimError") {
      console.log("Invalid token claim:", error.message);
      return unauthorizedResponse("Invalid token claims");
    } else if (error.name === "JwtInvalidSignatureError") {
      console.log("Invalid token signature");
      return unauthorizedResponse("Invalid token signature");
    } else {
      console.log("Token validation error:", error);
      return unauthorizedResponse("Invalid or expired token");
    }
  }
};

/**
 * 401 Unauthorized レスポンス
 * @param {string} message - エラーメッセージ
 * @returns {Object} CloudFront response object
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
