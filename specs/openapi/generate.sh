#!/usr/bin/env bash

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DESTDIR=${SDIR}/../../src

rm -rf ${SDIR}/client
java -jar openapi-generator-cli.jar generate \
    -i ${SDIR}/open_policy_agent.yaml \
    -g julia-client \
    -o ${SDIR}/client \
    --additional-properties=packageName=Client \
    --additional-properties=exportModels=false \
    --additional-properties=exportOperations=false

git rm -rf ${DESTDIR}/client
mkdir ${DESTDIR}
mv ${SDIR}/client ${DESTDIR}/
git add ${DESTDIR}/client
