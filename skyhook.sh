#!/bin/bash

## INIT
export AWS_PAGER=""

. ./scripts/util/logger.sh
. ./scripts/util/prerequisites.sh

. ./scripts/aws/s3.sh
. ./scripts/aws/cft.sh

check_prerequisites $1

## S3 UPLOAD
get_bucket_name
create_bucket
upload_to_s3

## BUILD STACK
create_stack

## WRAP UP
log "Done"
