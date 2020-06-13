#!/bin/bash

function check_prerequisites() {
    command -v aws
    awsExists=$?

    aws --version | grep "aws-cli/2\."
    awsRightVersion=$?

    if [ $awsExists -gt 0 ] || [ $awsRightVersion -gt 0 ]; then
        log "Please install aws cli v2 to proceed"
        exit 1
    fi

    if [ ! -f $HOME/.aws/credentials ]; then
        log "You have not yet setup your aws cli, running 'aws configure' for you..."
        aws configure
    fi

    if [ ! -f ./scripts/env/$1-env.sh ]; then
        log "Invalid environment, please enter dev, qa, or prod"
        exit 1
    else
        . ./scripts/env/$1-env.sh
    fi

    echo
    log "Prerequisites met, proceeding"
}
