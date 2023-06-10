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

# Flutter home
export FLUTTER_HOME=$HOME/Development/Flutter
export PATH=$PATH:$FLUTTER_HOME/bin

# Dart home
export DART_HOME=$HOME/Development/Dart
export PATH=$PATH:$DART_HOME/bin

# Java home
export JAVA_HOME=$HOME/Development/Java/Oracle/jdk-17
export PATH=$PATH:$JAVA_HOME/bin

# Mongo home
export MONGO_HOME=$HOME/Development/Mongo
export PATH=$PATH:$MONGO_HOME/bin

# NodeJs home
export NODEJS_HOME=$HOME/Development/NodeJs/bin
export PATH=$PATH:$NODEJS_HOME/bin

# DotNet
export DOTNET_ROOT=$HOME/Development/DotNet/
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT

# Flatpaks
alias android-studio="flatpak run com.google.AndroidStudio"
alias chrome="flatpak run com.google.Chrome"
alias code="flatpak run com.visualstudio.code"
alias firefox="flatpak run org.mozilla.firefox"
alias google-chrome="flatpak run com.google.Chrome"
alias insomnia="flatpak run rest.insomnia.Insomnia"
alias postman="flatpak run com.getpostman.Postman"
alias qbittorrent="flatpak run org.qbittorrent.qBittorrent"
alias spotify="flatpak run com.spotify.Client"
alias vlc="flatpak run org.videolan.VLC"
