# Purpose: in a single command put all main developers tools on place for work with a project
# How to use: execute this script by preceding with command "source" for alowing it to move your current directory

#!/bin/bash

# Move to the directory where your project is
cd path-to-your-project-root-folder

# Open a finder tab/window with this directroy
open .

# Detailed list of its content
ls -FGlAhp

# Check your repositroy status
git status

# Open the workspace with your default tool
open Your_Workspace.xcworkspace