// HTTPステータスコードを受け取ったら、そのコードをレスポンスとして返すサンプル関数
exports.handler = async (event) => {
  const statusCode =
    event.queryStringParameters && event.queryStringParameters.statusCode;
  const code = parseInt(statusCode, 10) || 200;
  return {
    statusCode: code,
    body: `Response with status code: ${code}`,
  };
};
