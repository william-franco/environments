sudo apt install lcov
sudo apt install zram-config
systemctl enable zram-config
systemctl start zram-config
sudo chmod +x necessary-verbs.sh && sudo ./necessary-verbs.sh && exit

cat /proc/sys/vm/swappiness
nano /usr/bin/init-zram-swapping
nano /etc/sysctl.conf

glxinfo | grep "OpenGL version"
force_vk_vendor="-1" steam

adb devices
adb connect 192.168.0.0:port
adb install -r app.apk

gcc -o build app.c && ./build
kotlinc-native app.kt -o build && ./build.kexe
lscpu
dotnet new webapi -n ProjectName

flutter pub run import_sorter:main lib\/* test\/*
dart pub run import_sorter:main lib\/* test\/*

# Cria um novo projeto com o nome da organização.
flutter create --org br.com.williamfranco project_name

# Recria as pastas do projeto com o nome da organização.
flutter create . --org br.com.williamfranco

# Remove as pastas dos desktops
rm -rf windows/ && rm -rf linux/ && rm -rf macos/ && rm -rf pubspec.lock

# Cria um novo projeto em ASP.NET Core.
dotnet new web -n ProjectName

# Cria um novo projeto em Vite.
npm create vite@latest project-name --template react
npm create vite@latest project-name
npm install lucide-react recharts tailwindcss @tailwindcss/vite
