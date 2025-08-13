#!/bin/bash
# エラー落ちで残骸が残っていたら面倒なので削除しておく
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

read -p "Enter MFA token code: " TOKEN_CODE

# 一時的な認証情報を取得
TEMP_CREDENTIALS=$(aws sts get-session-token --serial-number $MFA_ARN --token-code $TOKEN_CODE --profile $AWS_PROFILE)

# get-session-tokenの結果から認証情報を取り出し、環境変数に設定
export AWS_ACCESS_KEY_ID=$(echo $TEMP_CREDENTIALS | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $TEMP_CREDENTIALS | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $TEMP_CREDENTIALS | jq -r '.Credentials.SessionToken')

# MFAプロファイルを作成 (先に[mfa]) は空っぽで作っておく
aws configure set profile.$MFA_PROFILE.aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set profile.$MFA_PROFILE.aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set profile.$MFA_PROFILE.aws_session_token "$AWS_SESSION_TOKEN"

# 環境変数を削除
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

# MFAプロファイルでS3バケットの一覧を取得
# aws s3api list-buckets --profile $MFA_PROFILE