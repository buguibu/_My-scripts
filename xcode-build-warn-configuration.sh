# Purpose: warn users about critical configuration of current build for be sure of what you are doing
# How to use: add a 'Run script' phase on top of Build phases of the target and adapt the following content for paste there:
# source "${PROJECT_DIR}/xcode-build-warn-configuration.sh"
#!/bin/bash
BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$PRODUCT_SETTINGS_PATH")
VERSION_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$PRODUCT_SETTINGS_PATH")
BRANCH_NAME=$(/usr/bin/env git rev-parse --abbrev-ref HEAD)

WARN_BUILD_MESSAGE_FANCY="📲${TARGETNAME} ${VERSION_NUMBER}#${BUILD_NUMBER} ⚙️${CONFIGURATION} 🔀 $BRANCH_NAME"

WARN_BUILD_MESSAGE_PLAIN="${TARGETNAME} ${VERSION_NUMBER}#${BUILD_NUMBER} Config='${CONFIGURATION}' Branch='[$BRANCH_NAME]'"

echo "warning: ${WARN_BUILD_MESSAGE_FANCY}"


if [ "${CONFIGURATION}" != "Debug"  ]; then
    echo "${WARN_BUILD_MESSAGE_PLAIN}" | pbcopy
    say "Building '${TARGETNAME}' for ${CONFIGURATION}"
fi

osascript -e 'display notification "📲'${TARGETNAME}' '${VERSION_NUMBER}'#'${BUILD_NUMBER}' ⚙️'${CONFIGURATION}' 🔀 '$BRANCH_NAME'"'