# Add this of end the file .bashrc

# PATH Environments

# Refresh terminal with: source ~/.bashrc
# Check the path with: echo $PATH

# Android Studio
export ANDROID_HOME=$HOME/Development/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Flutter
export FLUTTER_HOME=$HOME/Development/Flutter/bin
export PATH=$PATH:$FLUTTER_HOME

# Java home
export JAVA_HOME=$HOME/Development/Java/Oracle/jdk-17
export PATH=$PATH:$JAVA_HOME/bin

# Nodejs
export PATH=$PATH:/usr/bin/node
export PATH=$PATH:/usr/bin/npm

# MySQL
export PATH=$PATH:/usr/bin/mysql-workbench
