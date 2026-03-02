# Environments

Settings of PATH in Environment Variables on Mac and Linux.


## Linux:

```
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
```

## Macos:

```
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
```


## License

MIT License

Copyright (c) 2026 William Franco

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
