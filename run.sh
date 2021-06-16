#!/usr/bin/env bash
set -Eeuo pipefail

readonly SEC1_KEY_PATH="/apiserver.local.config/certificates/apiserver.key"
readonly PKCS8_KEY_PATH="/work/tls.key"

# The openssl conversion is needed when installing through the OLM, as the generated 
# key is in SEC1/PEM format instead of PKCS8/PEM, which is required by the JDK.
openssl pkcs8 -topk8 -inform pem -in $SEC1_KEY_PATH -outform pem -nocrypt -out $PKCS8_KEY_PATH
/work/application -Dquarkus.http.host=0.0.0.0 --kafka --zookeeper
