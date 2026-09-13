#!/usr/bin/env bash
#
# initial-config-linux.sh
# ------------------------------------------------------------------
# Script de configuração inicial de ambiente de desenvolvimento Linux
# (Ubuntu/Debian). NÃO utiliza snap nem flatpak.
#
# Estratégia de instalação:
#   - apt (repo oficial do fornecedor) -> htop, VS Code, Chrome, Edge, Spotify
#   - script oficial (curl)            -> Zed, DotNet
#   - tarball/AppImage oficial         -> Android Studio, Cursor, Postman,
#                                          Java (Oracle JDK), Flutter, NodeJS
#
# Ferramentas de linguagem (Flutter, Java, NodeJS, DotNet) ficam
# organizadas em ~/Development, conforme o seu .bashrc. A pasta do
# Android SDK (~/Development/Android/Sdk) também é criada; aponte o
# Android Studio pra ela no assistente de primeira execução.
#
# Uso:
#   chmod +x initial-config-linux.sh
#   ./initial-config-linux.sh
# ------------------------------------------------------------------

set -uo pipefail

# ------------------------------------------------------------------
# Configurações / versões (ajuste aqui se algum link expirar)
# ------------------------------------------------------------------
DEV_DIR="$HOME/Development"

JAVA_VERSION="25"
JAVA_TARBALL_URL="https://download.oracle.com/java/${JAVA_VERSION}/latest/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"

NODEJS_VERSION="22"   # LTS ativa no momento (ajuste se necessário)

ANDROID_STUDIO_VERSION="2024.3.2.14"
ANDROID_STUDIO_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${ANDROID_STUDIO_VERSION}/android-studio-${ANDROID_STUDIO_VERSION}-linux.tar.gz"

# .deb oficial da Cursor - ao abrir o app pela 1a vez, ele mesmo registra
# um repositorio apt e passa a atualizar via "apt upgrade".
# Se o link expirar, pegue o mais recente em https://cursor.com/downloads
CURSOR_DEB_URL="https://api2.cursor.sh/updates/download/golden/linux-x64-deb/cursor/latest"

POSTMAN_TARBALL_URL="https://dl.pstmn.io/download/latest/linux64"

# ------------------------------------------------------------------
# Helpers de output
# ------------------------------------------------------------------
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_step()  { echo -e "\n${GREEN}==>${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[AVISO]${NC} $1"; }
log_error() { echo -e "${RED}[ERRO]${NC} $1"; }
log_ok()    { echo -e "${GREEN}[OK]${NC} $1"; }

run_or_warn() {
    local desc="$1"; shift
    if "$@"; then
        log_ok "$desc"
    else
        log_error "Falha em: $desc (continuando...)"
    fi
}

# ------------------------------------------------------------------
# 0. Pré-requisitos
# ------------------------------------------------------------------
install_prereqs() {
    log_step "Atualizando apt e instalando pré-requisitos"
    sudo apt update
    sudo apt install -y \
        curl wget gpg ca-certificates apt-transport-https \
        software-properties-common unzip xz-utils jq \
        libfuse2 build-essential
}

# ------------------------------------------------------------------
# 1. Estrutura de pastas ~/Development
# ------------------------------------------------------------------
setup_dev_folders() {
    log_step "Criando estrutura em $DEV_DIR"
    mkdir -p "$DEV_DIR/Flutter"
    mkdir -p "$DEV_DIR/Java/JavaVirtualMachines"
    mkdir -p "$DEV_DIR/NodeJs"
    mkdir -p "$DEV_DIR/DotNet"
    mkdir -p "$DEV_DIR/Android/Sdk"
    log_ok "Pastas criadas"
}

# ------------------------------------------------------------------
# 2. htop (apt)
# ------------------------------------------------------------------
install_htop() {
    log_step "Instalando htop (apt)"
    sudo apt install -y htop
}

# ------------------------------------------------------------------
# 3. Google Chrome (repo oficial via apt)
# ------------------------------------------------------------------
install_chrome() {
    log_step "Instalando Google Chrome (repo oficial)"
    if command -v google-chrome >/dev/null 2>&1; then
        log_warn "Chrome já instalado, pulando"
        return
    fi
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | \
        sudo gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | \
        sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
    sudo apt update
    sudo apt install -y google-chrome-stable
}

# ------------------------------------------------------------------
# 4. Microsoft Edge (repo oficial via apt)
# ------------------------------------------------------------------
install_edge() {
    log_step "Instalando Microsoft Edge (repo oficial)"
    if command -v microsoft-edge >/dev/null 2>&1; then
        log_warn "Edge já instalado, pulando"
        return
    fi
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | \
        sudo gpg --dearmor -o /etc/apt/keyrings/microsoft-edge.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" | \
        sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
    sudo apt update
    sudo apt install -y microsoft-edge-stable
}

# ------------------------------------------------------------------
# 5. Visual Studio Code (repo oficial via apt)
# ------------------------------------------------------------------
install_vscode() {
    log_step "Instalando Visual Studio Code (repo oficial)"
    if command -v code >/dev/null 2>&1; then
        log_warn "VS Code já instalado, pulando"
        return
    fi
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | \
        sudo gpg --dearmor -o /etc/apt/keyrings/vscode.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/vscode.gpg] https://packages.microsoft.com/repos/code stable main" | \
        sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt update
    sudo apt install -y code
}

# ------------------------------------------------------------------
# 6. Spotify (repo oficial via apt)
# ------------------------------------------------------------------
install_spotify() {
    log_step "Instalando Spotify (repo oficial)"
    if command -v spotify >/dev/null 2>&1; then
        log_warn "Spotify já instalado, pulando"
        return
    fi
    curl -fsSL https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/spotify.gpg
    echo "deb [signed-by=/etc/apt/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | \
        sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
    sudo apt update
    sudo apt install -y spotify-client
}

# ------------------------------------------------------------------
# 7. Zed (script oficial)
# ------------------------------------------------------------------
install_zed() {
    log_step "Instalando Zed (script oficial)"
    if command -v zed >/dev/null 2>&1; then
        log_warn "Zed já instalado, pulando"
        return
    fi
    curl -f https://zed.dev/install.sh | sh
}

# ------------------------------------------------------------------
# 8. Android Studio (tarball oficial em /opt + comando de update próprio)
#    Google só oferece tar.gz ou Snap para Linux; sem Snap, não existe
#    apt/deb oficial. Para permitir "update pelo terminal" mesmo assim,
#    criamos o comando `android-studio-update`.
# ------------------------------------------------------------------
install_android_studio() {
    log_step "Instalando Android Studio (tarball oficial)"
    if [ -d "/opt/android-studio" ]; then
        log_warn "Android Studio já instalado em /opt, pulando"
    else
        local tmp="/tmp/android-studio.tar.gz"
        wget -O "$tmp" "$ANDROID_STUDIO_URL" || {
            log_error "Download do Android Studio falhou. Verifique/atualize ANDROID_STUDIO_URL no topo do script: https://developer.android.com/studio"
            return 1
        }
        sudo tar -xzf "$tmp" -C /opt/
        rm -f "$tmp"
        sudo ln -sf /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio

        cat <<EOF | sudo tee /usr/share/applications/android-studio.desktop > /dev/null
[Desktop Entry]
Name=Android Studio
Exec=/opt/android-studio/bin/studio.sh
Icon=/opt/android-studio/bin/studio.svg
Type=Application
Categories=Development;IDE;
EOF
        log_ok "Android Studio instalado em /opt/android-studio"
    fi

    # Cria comando de atualização via terminal: android-studio-update
    cat <<'UPDATER' | sudo tee /usr/local/bin/android-studio-update > /dev/null
#!/usr/bin/env bash
# Reinstala o Android Studio com a versao mais recente do tar.gz oficial.
# Ajuste a URL abaixo quando o Google lancar uma nova versao estavel.
set -e
URL="__ANDROID_STUDIO_URL__"
TMP="/tmp/android-studio-update.tar.gz"
echo "Baixando Android Studio..."
wget -O "$TMP" "$URL"
sudo rm -rf /opt/android-studio
sudo tar -xzf "$TMP" -C /opt/
rm -f "$TMP"
sudo ln -sf /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio
echo "Android Studio atualizado."
UPDATER
    sudo sed -i "s|__ANDROID_STUDIO_URL__|$ANDROID_STUDIO_URL|" /usr/local/bin/android-studio-update
    sudo chmod +x /usr/local/bin/android-studio-update
    log_ok "Comando 'android-studio-update' criado"
}

# ------------------------------------------------------------------
# 9. Cursor (.deb oficial - atualiza via apt depois do 1o uso)
#    A propria Cursor confirma: ao baixar o .deb e abrir o app uma vez,
#    ele registra um repositorio apt no sistema e passa a atualizar
#    normalmente via "apt upgrade".
# ------------------------------------------------------------------
install_cursor() {
    log_step "Instalando Cursor (.deb oficial)"
    if command -v cursor >/dev/null 2>&1; then
        log_warn "Cursor já instalado, pulando"
        return
    fi
    local tmp="/tmp/cursor.deb"
    wget -O "$tmp" "$CURSOR_DEB_URL" || {
        log_error "Download do Cursor falhou. Baixe o .deb manualmente em https://cursor.com/downloads e rode: sudo apt install ./cursor.deb"
        return 1
    }
    sudo apt install -y "$tmp"
    rm -f "$tmp"
    log_ok "Cursor instalado via .deb"
    log_warn "Abra o Cursor pelo menos 1 vez para ele registrar o repositório apt e habilitar 'sudo apt upgrade' nas próximas atualizações"
}

# ------------------------------------------------------------------
# 10. Postman (tarball oficial em /opt + comando de update próprio)
#     Postman não tem apt/deb oficial (só Snap, Flatpak ou tarball).
#     Sem Snap/Flatpak, criamos o comando `postman-update`.
# ------------------------------------------------------------------
install_postman() {
    log_step "Instalando Postman (tarball oficial)"
    if [ -d "/opt/Postman" ]; then
        log_warn "Postman já instalado, pulando"
    else
        local tmp="/tmp/postman.tar.gz"
        wget -O "$tmp" "$POSTMAN_TARBALL_URL"
        sudo tar -xzf "$tmp" -C /opt/
        rm -f "$tmp"
        sudo ln -sf /opt/Postman/Postman /usr/local/bin/postman

        cat <<EOF | sudo tee /usr/share/applications/postman.desktop > /dev/null
[Desktop Entry]
Name=Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Type=Application
Categories=Development;
EOF
        log_ok "Postman instalado em /opt/Postman"
    fi

    # Cria comando de atualização via terminal: postman-update
    cat <<'UPDATER' | sudo tee /usr/local/bin/postman-update > /dev/null
#!/usr/bin/env bash
# Reinstala o Postman com a versao mais recente do tar.gz oficial.
set -e
URL="https://dl.pstmn.io/download/latest/linux64"
TMP="/tmp/postman-update.tar.gz"
echo "Baixando Postman..."
wget -O "$TMP" "$URL"
sudo rm -rf /opt/Postman
sudo tar -xzf "$TMP" -C /opt/
rm -f "$TMP"
sudo ln -sf /opt/Postman/Postman /usr/local/bin/postman
echo "Postman atualizado."
UPDATER
    sudo chmod +x /usr/local/bin/postman-update
    log_ok "Comando 'postman-update' criado"
}

# ------------------------------------------------------------------
# 11. Java Oracle JDK (tarball oficial em ~/Development/Java)
# ------------------------------------------------------------------
install_java() {
    log_step "Instalando Java Oracle JDK $JAVA_VERSION"
    local target="$DEV_DIR/Java/JavaVirtualMachines/jdk-${JAVA_VERSION}"
    if [ -d "$target" ]; then
        log_warn "JDK $JAVA_VERSION já existe em $target, pulando"
        return
    fi
    local tmp="/tmp/jdk.tar.gz"
    wget -O "$tmp" "$JAVA_TARBALL_URL" || {
        log_error "Download do JDK falhou. Confira a URL atual em https://www.oracle.com/java/technologies/downloads/"
        return 1
    }
    mkdir -p "$DEV_DIR/Java/JavaVirtualMachines"
    tar -xzf "$tmp" -C "$DEV_DIR/Java/JavaVirtualMachines/"
    rm -f "$tmp"
    # normaliza o nome da pasta extraída para "jdk-<versao>"
    local extracted
    extracted=$(find "$DEV_DIR/Java/JavaVirtualMachines" -maxdepth 1 -type d -name "jdk-${JAVA_VERSION}*" | head -n1)
    if [ -n "$extracted" ] && [ "$extracted" != "$target" ]; then
        mv "$extracted" "$target"
    fi
    log_ok "Java JDK $JAVA_VERSION instalado em $target"
}

# ------------------------------------------------------------------
# 12. Flutter (tarball oficial em ~/Development/Flutter)
# ------------------------------------------------------------------
install_flutter() {
    log_step "Instalando Flutter (canal stable)"
    if [ -d "$DEV_DIR/Flutter/bin" ]; then
        log_warn "Flutter já existe em $DEV_DIR/Flutter, pulando"
        return
    fi
    local manifest_url="https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json"
    local flutter_url
    flutter_url=$(curl -fsSL "$manifest_url" | jq -r '.current_release.stable as $h | .releases[] | select(.hash==$h) | .archive' | head -n1)
    flutter_url="https://storage.googleapis.com/flutter_infra_release/releases/${flutter_url}"

    local tmp="/tmp/flutter.tar.xz"
    wget -O "$tmp" "$flutter_url" || {
        log_error "Download do Flutter falhou"
        return 1
    }
    tar -xJf "$tmp" -C /tmp/
    rm -rf "$DEV_DIR/Flutter"
    mv /tmp/flutter "$DEV_DIR/Flutter"
    rm -f "$tmp"
    log_ok "Flutter instalado em $DEV_DIR/Flutter"
}

# ------------------------------------------------------------------
# 13. NodeJS LTS (tarball oficial em ~/Development/NodeJs)
# ------------------------------------------------------------------
install_nodejs() {
    log_step "Instalando NodeJS LTS $NODEJS_VERSION.x"
    if [ -d "$DEV_DIR/NodeJs/bin" ]; then
        log_warn "NodeJS já existe em $DEV_DIR/NodeJs, pulando"
        return
    fi
    local latest
    latest=$(curl -fsSL "https://nodejs.org/dist/latest-v${NODEJS_VERSION}.x/" | \
        grep -oP "node-v${NODEJS_VERSION}\.\d+\.\d+-linux-x64\.tar\.xz" | head -n1)
    local node_url="https://nodejs.org/dist/latest-v${NODEJS_VERSION}.x/${latest}"

    local tmp="/tmp/nodejs.tar.xz"
    wget -O "$tmp" "$node_url" || {
        log_error "Download do NodeJS falhou"
        return 1
    }
    tar -xJf "$tmp" -C /tmp/
    local extracted_dir
    extracted_dir=$(tar -tJf "$tmp" | head -1 | cut -f1 -d"/")
    rm -rf "$DEV_DIR/NodeJs"
    mv "/tmp/${extracted_dir}" "$DEV_DIR/NodeJs"
    rm -f "$tmp"
    log_ok "NodeJS instalado em $DEV_DIR/NodeJs"
}

# ------------------------------------------------------------------
# 14. DotNet Core LTS (script oficial em ~/Development/DotNet)
# ------------------------------------------------------------------
install_dotnet() {
    log_step "Instalando .NET Core LTS"
    if [ -x "$DEV_DIR/DotNet/dotnet" ]; then
        log_warn ".NET já existe em $DEV_DIR/DotNet, pulando"
        return
    fi
    curl -sSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
    chmod +x /tmp/dotnet-install.sh
    /tmp/dotnet-install.sh --channel LTS --install-dir "$DEV_DIR/DotNet"
    rm -f /tmp/dotnet-install.sh

    mkdir -p "$HOME/.dotnet/tools"
    log_ok ".NET instalado em $DEV_DIR/DotNet"
}

# ------------------------------------------------------------------
# 11. Claude Code (instalador nativo oficial - se auto-atualiza)
# ------------------------------------------------------------------
install_claude_code() {
    log_step "Instalando Claude Code (instalador nativo oficial)"
    if command -v claude >/dev/null 2>&1; then
        log_warn "Claude Code já instalado, pulando"
        return
    fi
    curl -fsSL https://claude.ai/install.sh | bash
    log_ok "Claude Code instalado (atualiza sozinho; para forçar: claude update)"
}

# ------------------------------------------------------------------
# 12. Variáveis de ambiente no .bashrc (idempotente)
# ------------------------------------------------------------------
setup_bashrc() {
    log_step "Configurando variáveis de ambiente no ~/.bashrc"
    local marker="# >>> initial-config-linux.sh managed block >>>"
    local end_marker="# <<< initial-config-linux.sh managed block <<<"

    if grep -qF "$marker" "$HOME/.bashrc" 2>/dev/null; then
        log_warn "Bloco já existe no .bashrc, pulando (edite manualmente se precisar atualizar)"
        return
    fi

    cat >> "$HOME/.bashrc" <<EOF

$marker
# Android Studio Home
export ANDROID_HOME=\$HOME/Development/Android/Sdk
export PATH=\$PATH:\$ANDROID_HOME/emulator
export PATH=\$PATH:\$ANDROID_HOME/tools
export PATH=\$PATH:\$ANDROID_HOME/tools/bin
export PATH=\$PATH:\$ANDROID_HOME/platform-tools

# Flutter Home
export FLUTTER_HOME=\$HOME/Development/Flutter
export PATH=\$PATH:\$FLUTTER_HOME/bin

# Java Home
export JAVA_HOME=\$HOME/Development/Java/JavaVirtualMachines/jdk-${JAVA_VERSION}
export PATH=\$PATH:\$JAVA_HOME/bin

# NodeJs Home
export NODEJS_HOME=\$HOME/Development/NodeJs
export PATH=\$PATH:\$NODEJS_HOME/bin

# DotNet home
export DOTNET_ROOT=\$HOME/Development/DotNet/
export PATH=\$PATH:\$DOTNET_ROOT:\$DOTNET_ROOT
export PATH="\$PATH:\$HOME/.dotnet/tools"

# Claude Code (instalador nativo usa ~/.local/bin)
export PATH="\$PATH:\$HOME/.local/bin"
$end_marker
EOF
    log_ok "Bloco adicionado ao ~/.bashrc"
}

# ------------------------------------------------------------------
# Main
# ------------------------------------------------------------------
main() {
    run_or_warn "Pré-requisitos"        install_prereqs
    run_or_warn "Pastas ~/Development"  setup_dev_folders

    run_or_warn "htop"                  install_htop
    run_or_warn "Google Chrome"         install_chrome
    run_or_warn "Microsoft Edge"        install_edge
    run_or_warn "Visual Studio Code"    install_vscode
    run_or_warn "Spotify"               install_spotify
    run_or_warn "Zed"                   install_zed
    run_or_warn "Android Studio"        install_android_studio
    run_or_warn "Cursor"                install_cursor
    run_or_warn "Postman"               install_postman
    run_or_warn "Java JDK"              install_java
    run_or_warn "Flutter"               install_flutter
    run_or_warn "NodeJS"                install_nodejs
    run_or_warn "DotNet"                install_dotnet
    run_or_warn "Claude Code"           install_claude_code
    run_or_warn "Configuração .bashrc"  setup_bashrc

    echo -e "\n${GREEN}==================================================${NC}"
    echo -e "${GREEN}Instalação concluída!${NC}"
    echo "Rode: source ~/.bashrc"
    echo "Verifique cada ferramenta com: flutter doctor / java -version / node -v / dotnet --version"
    echo ""
    echo "Atualizacoes futuras:"
    echo "  - apt (htop, Chrome, Edge, VS Code, Spotify, Cursor*): sudo apt update && sudo apt upgrade"
    echo "    *Cursor: abra o app 1x apos instalar para ele registrar o repositorio apt"
    echo "  - Zed: zed --update (ou rode o install.sh de novo)"
    echo "  - Android Studio: android-studio-update"
    echo "  - Postman: postman-update"
    echo "  - Claude Code: se atualiza sozinho (ou rode: claude update)"
    echo -e "${GREEN}==================================================${NC}\n"
}

main "$@"
