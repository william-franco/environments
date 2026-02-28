# PATH Environments

# Refresh terminal with: source ~/.zshrc
# Check the path with: echo $PATH

# Android Studio Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Flutter Home
export FLUTTER_HOME=$HOME/Library/Flutter/bin
export PATH=$PATH:$FLUTTER_HOME

# Dart Home
export DART_HOME=$HOME/Library/Dart/bin
export PATH=$PATH:$DART_HOME

# Java Home
export JAVA_HOME=$HOME/Library/Java/JavaVirtualMachines/jdk-21/Contents/Home

# NodeJs Home
export NODEJS_HOME=$HOME/Library/NodeJs/bin
export PATH=$NODEJS_HOME:$PATH
