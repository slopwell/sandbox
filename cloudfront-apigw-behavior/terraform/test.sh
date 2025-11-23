API_GW_HOST="https://kbnbos9k24.execute-api.ap-northeast-1.amazonaws.com"
API_GW_DEV="$API_GW_HOST/dev/hello"
API_GW_PROD="$API_GW_HOST/prod/hello"
CLOUDFRONT_DOMAIN="https://d1rvftgnh9mofa.cloudfront.net"
CLOUDFRONT_API="$CLOUDFRONT_DOMAIN/api/hello"

echo "=== APIGW Dev"
curl -i $API_GW_DEV
echo ""
echo "=== APIGW Prod"
curl -i $API_GW_PROD
echo ""
echo "=== CloudFront"
curl -i $CLOUDFRONT_API
echo ""
