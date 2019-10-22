#!/bin/bash

SECRET_TOKEN=$1
REPO=$2
CONFIG=$3
PROJECT=$4

EMBUILD=/ses/bin/emBuild

git clone https://${SECRET_TOKEN}@github.com/${REPO} /repo

${EMBUILD} -verbose -config ${CONFIG} -batch /repo/${PROJECT}
