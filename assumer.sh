#!/bin/bash
  
SERIAL_NUMBER='arn:aws:iam::xxxxxxxxxxxx:mfa/xxxxxxxxxxxx'
SOURCE_PROFILE='xxxxxxxxxxxx'
DATE=`date +%s`

PROFILE=`grep -oP '\[profile *\K\w+' ~/.aws/config  | fzf`

if [ "$PROFILE" = "" ]; then
  return 1
fi

ROLE_ARN=`aws configure get role_arn --profile $PROFILE`

read -sp "Input MFA Code: " TOKEN_CODE

OUTPUT=`aws sts assume-role \
  --role-arn          ${ROLE_ARN} \
  --serial-number     ${SERIAL_NUMBER} \
  --role-session-name ${DATE}-session \
  --profile           ${SOURCE_PROFILE} \
  --duration-second   3600 \
  --token-code        ${TOKEN_CODE}
`
export AWS_ACCESS_KEY_ID=`echo $OUTPUT | jq -r .Credentials.AccessKeyId`
export AWS_SECRET_ACCESS_KEY=`echo $OUTPUT | jq -r .Credentials.SecretAccessKey`
export AWS_SESSION_TOKEN=`echo $OUTPUT | jq -r .Credentials.SessionToken`

echo ""
