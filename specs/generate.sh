#!/usr/bin/env bash

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DESTDIR=${SDIR}/..

java -jar openapi-generator-cli.jar generate \
    -i ${SDIR}/open_policy_agent.yaml \
    -g julia-client \
    -o ${SDIR}/OpenPolicyAgent \
    --additional-properties=packageName=OpenPolicyAgent \
    --additional-properties=exportModels=false \
    --additional-properties=exportOperations=false

git rm -rf ${DESTDIR}/apidocs ${DESTDIR}/src
mkdir ${DESTDIR}/apidocs
mv ${SDIR}/OpenPolicyAgent/README.md ${DESTDIR}/apidocs/
mv ${SDIR}/OpenPolicyAgent/docs ${DESTDIR}/apidocs/
git add  ${DESTDIR}/apidocs
mv ${SDIR}/OpenPolicyAgent/src ${DESTDIR}/
git add ${DESTDIR}/src
