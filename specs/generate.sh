java -jar openapi-generator-cli.jar generate \
    -i open_policy_agent.yaml \
    -g julia-client \
    -o OpenPolicyAgent \
    --additional-properties=packageName=OpenPolicyAgent \
    --additional-properties=exportModels=false \
    --additional-properties=exportOperations=false

git rm -rf ../apidocs ../src
mkdir ../apidocs ../src
mv OpenPolicyAgent/README.md ../apidocs/
mv OpenPolicyAgent/docs ../apidocs/
git add  ../apidocs
mv OpenPolicyAgent/src ../src
git add ../src
