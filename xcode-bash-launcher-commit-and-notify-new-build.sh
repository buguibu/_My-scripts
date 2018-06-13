# Purpose: warn users about critical configuration of current build for be sure of what you are doing
# How to use: add a 'Run script' phase on top of Build phases of the target and adapt the following content for paste there:
# source "${PROJECT_DIR}/xcode-build-warn-configuration.sh"
#!/bin/bash
BUILD_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "$PRODUCT_SETTINGS_PATH")
VERSION_NUMBER=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$PRODUCT_SETTINGS_PATH")
BRANCH_NAME=$(/usr/bin/env git rev-parse --abbrev-ref HEAD)

echo "warning: 📲${TARGETNAME} ${VERSION_NUMBER}#${BUILD_NUMBER} ⚙️${CONFIGURATION} 🔀 $BRANCH_NAME"

if [ "${CONFIGURATION}" != "Debug" ]; then
  #!/usr/bin/env osascript
  osascript <<EOD
  set notifierScript to load script (POSIX file "/Users/vgutierreznologis.com/Projects/_My-scripts/xcode-commit-and-notify-new-build.scpt")
  tell notifierScript
    set its projectPath to "${PROJECT_DIR}"
    set its targetName to "${TARGETNAME}"
    set its configurationMode to "${CONFIGURATION}"
    set its buildNumber to "${BUILD_NUMBER}"
    set its versionNumber to "${VERSION_NUMBER}"
    set its branchName to "$BRANCH_NAME"
    set its slackChanel to "the_style_outlets"
    newBuildNotifier()
  end tell
  EOD
fi
