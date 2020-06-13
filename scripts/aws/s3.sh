#!/bin/bash

function get_bucket_name() {
    export S3_BUCKET_NAME=$(echo "$PROJECT-$ENVIRONMENT-$(date +%Y%m%d%H%M%S%Z)" | tr '[:upper:]' '[:lower:]')
}

function create_bucket() {
    log "S3_BUCKET_NAME=$S3_BUCKET_NAME"

    aws s3 mb s3://$S3_BUCKET_NAME --region $REGION
}

function upload_to_s3() {
    aws s3 sync ./cloudformation/templates/ s3://$S3_BUCKET_NAME/templates/ --sse AES256 --acl private --no-progress
}
