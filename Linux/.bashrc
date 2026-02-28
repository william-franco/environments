# Add this of end the file .bashrc

# PATH Environments

# Refresh terminal with: source ~/.bashrc
# Check the path with: echo $PATH

# Android Studio Home
export ANDROID_HOME=$HOME/Development/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Flutter Home
export FLUTTER_HOME=$HOME/Development/Flutter
export PATH=$PATH:$FLUTTER_HOME/bin

# Dart Home
export DART_HOME=$HOME/Development/Dart
export PATH=$PATH:$DART_HOME/bin

# Java Home
export JAVA_HOME=$HOME/Development/Java/JavaVirtualMachines/jdk-21
export PATH=$PATH:$JAVA_HOME/bin

# Kotlin Home
export KOTLIN_HOME=$HOME/Development/Kotlin
export PATH=$PATH:$KOTLIN_HOME/bin

# Kotlin Native Home
export KOTLINNATIVE_HOME=$HOME/Development/KotlinNative
export PATH=$PATH:$KOTLINNATIVE_HOME/bin

# NodeJs Home
export NODEJS_HOME=$HOME/Development/NodeJs
export PATH=$PATH:$NODEJS_HOME/bin

# DotNet home
export DOTNET_ROOT=$HOME/Development/DotNet/
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT

# Rust Home
. "$HOME/.cargo/env"

# Flatpaks
alias f-android-studio="flatpak run com.google.AndroidStudio"
alias f-chrome="flatpak run com.google.Chrome"
alias f-code="flatpak run com.visualstudio.code"
alias f-firefox="flatpak run org.mozilla.firefox"
alias f-google-chrome="flatpak run com.google.Chrome"
alias f-insomnia="flatpak run rest.insomnia.Insomnia"
alias f-postman="flatpak run com.getpostman.Postman"
alias f-qbittorrent="flatpak run org.qbittorrent.qBittorrent"
alias f-spotify="flatpak run com.spotify.Client"
alias f-vlc="flatpak run org.videolan.VLC"
alias f-zed="flatpak run dev.zed.Zed"
