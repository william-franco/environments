# Environments

Settings of PATH in Environment Variables on Mac and Linux.

## Author

William Franco.

### Mac:

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

### Linux:

```
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
```

## License

MIT License

Copyright (c) 2023 William Franco

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
