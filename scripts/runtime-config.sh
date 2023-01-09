#!/bin/sh

# Inserts a runtime config object into an `index.html` file to handle environment changes and
# allows environment variables to be set at deployment time.
#
# - This script mostly mirrors `runtime-config.ps1` so that it can be run on non-Windows machines
# - Reference: https://medium.com/js-dojo/vue-js-runtime-environment-variables-807fa8f68665
# - Example: `./scripts/runtime-config.sh setConfig ./dist/angular-environment-service https://test.api.url false`

# Command to run (setConfig, resetConfig)
COMMAND=$1
# Environment specific installation location (physical path)
INSTALLATION_PATH=$2
# Environment specific API URL
API_URL=$3
# Toggles logging, test SSO, and others (true/false)
IS_PRODUCTION=$4
# File suffix to track original version
SUFFIX=".pre-runtime-config"

setConfig ()
{
    echo "runtime-config.sh :: setConfig :: params = API_URL=$API_URL, IS_PRODUCTION=$IS_PRODUCTION"

    JSON_STRING='window.environment = { \
        "production": '"${IS_PRODUCTION}"', \
        "apiUrl": "'"${API_URL}"'", \
    }'

    echo "runtime-config.sh :: setConfig :: Applying index.html environment transform..."

    sed -i$SUFFIX "s@// RUNTIME_PLACEHOLDER@${JSON_STRING}@" "$INSTALLATION_PATH/index.html" || exit 1

    echo "runtime-config.sh :: setConfig :: Applying index.html environment transform complete."
}

resetConfig ()
{
    echo "runtime-config.sh :: resetConfig :: params = INSTALLATION_PATH=$INSTALLATION_PATH"
    echo "runtime-config.sh :: resetConfig :: Removing modified file..."
    rm $INSTALLATION_PATH/index.html || exit 1
    echo "runtime-config.sh :: resetConfig :: Replacing with origninal file..."
    mv $INSTALLATION_PATH/index.html$SUFFIX $INSTALLATION_PATH/index.html || exit 1
    echo "runtime-config.sh :: resetConfig :: Complete."
}

case "$COMMAND" in
    "setConfig")
        setConfig
        exit 0;;
    "resetConfig")
        resetConfig
        exit 0;;
    *)
        echo "runtime-config.sh :: Unrecognized command \"$COMMAND\"."
        exit 1;;
esac
