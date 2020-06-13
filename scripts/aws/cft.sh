#!/bin/bash

function create_stack() {
    sed -i .bkp -e "s/%BUCKET_NAME%/$S3_BUCKET_NAME/g" ./cloudformation/template-parameters/master-$ENVIRONMENT.json

    STACK_NAME="$PROJECT-$ENVIRONMENT"

    log "Creating the $ENVIRONMENT stack"
    aws cloudformation create-stack --stack-name $STACK_NAME \
    --template-body file://cloudformation/templates/master.yaml \
    --parameters file://cloudformation/template-parameters/master-$ENVIRONMENT.json \
    --region $REGION

    log "Waiting for $STACK_NAME to be CREATE_COMPLETE"
    aws cloudformation wait stack-create-complete --stack-name $STACK_NAME --region $REGION

    log "$STACK_NAME CREATE_COMPLETE"

    mv ./cloudformation/template-parameters/master-$ENVIRONMENT.json.bkp ./cloudformation/template-parameters/master-$ENVIRONMENT.json
}
