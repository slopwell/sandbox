exports.handler = async (event) => {
  // リクエストコンテキストからステージ名を取得
  const stage = event.requestContext?.stage || "unknown";

  // ログ出力
  console.log("Lambda function invoked");
  console.log("Stage:", stage);
  console.log("Request path:", event.path);
  console.log("HTTP method:", event.httpMethod);

  // レスポンス
  const response = {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      message: `Hello World from stage: ${stage}`,
      stage: stage,
      timestamp: new Date().toISOString(),
    }),
  };

  console.log("Response:", JSON.stringify(response));

  return response;
};
