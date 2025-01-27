#!/bin/bash

SECRET_TOKEN=$1
REPO=$2
COMMIT=$3
CONFIG=$4
PROJECT=$5
ARTIFACT=$6
MAPPED_DIR=$7
POST_BUILD_SCRIPT=$8

EMBUILD=/ses/bin/emBuild

git clone https://${SECRET_TOKEN}@github.com/${REPO} /repo

cd /repo
git checkout ${COMMIT}

echo "Updating Submodules..."
git submodule update --init --recursive

pip install -r requirements.txt

${EMBUILD} -verbose -config ${CONFIG} -D EXT_COMMIT_HASH=\"${COMMIT}\" -batch /repo/${PROJECT}

if test -f "$POST_BUILD_SCRIPT"; then
    ${POST_BUILD_SCRIPT} ${MAPPED_DIR}
fi

cp $ARTIFACT $MAPPED_DIR

