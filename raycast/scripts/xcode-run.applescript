#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Xcode Run
# @raycast.mode silent
# @raycast.icon 🔨
# @raycast.packageName Xcode

if application "Xcode" is running then
    tell application "Xcode" to run active workspace document
    return "Building…"
else
    return "Xcode isn't open"
end if
