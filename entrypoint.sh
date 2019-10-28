#!/bin/bash

SECRET_TOKEN=$1
REPO=$2
COMMIT=$3
CONFIG=$4
PROJECT=$5
ARTIFACT=$6
MAPPED_DIR=$7

EMBUILD=/ses/bin/emBuild

git clone https://${SECRET_TOKEN}@github.com/${REPO} /repo

cd /repo
git checkout ${COMMIT}

${EMBUILD} -verbose -config ${CONFIG} -batch /repo/${PROJECT}

cp $ARTIFACT $MAPPED_DIR

