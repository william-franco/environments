#!/usr/bin/env bash
#
# initial-config-macos.sh
# ------------------------------------------------------------------
# Configuração inicial de ambiente de desenvolvimento no macOS,
# 100% via Homebrew (formulae + casks). Sem AppImage, sem tarball
# manual: tudo se atualiza depois com "brew upgrade".
#
# Diferença chave em relação à versão Linux:
#   - No Homebrew, os binários caem automaticamente em
#     $(brew --prefix)/bin, que já está no PATH. Não é preciso
#     declarar FLUTTER_HOME / NODEJS_HOME manualmente.
#   - JAVA_HOME e DOTNET_ROOT continuam precisando de export
#     explícito (não são resolvidos sozinhos pelo shell).
#
# Uso:
#   chmod +x initial-config-macos.sh
#   ./initial-config-macos.sh
# ------------------------------------------------------------------

set -uo pipefail

# ------------------------------------------------------------------
# Configurações
# ------------------------------------------------------------------
JAVA_VERSION="25"
ANDROID_SDK_DIR="$HOME/Library/Android/sdk"   # local padrão do Android Studio no macOS
SHELL_RC="$HOME/.zshrc"                       # zsh é o shell padrão desde macOS Catalina

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
# 0. Homebrew (instala se não existir)
# ------------------------------------------------------------------
install_homebrew() {
    log_step "Verificando Homebrew"
    if command -v brew >/dev/null 2>&1; then
        log_ok "Homebrew já instalado"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Garante o brew no PATH desta sessão (Apple Silicon vs Intel)
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    brew update
}

# ------------------------------------------------------------------
# 1. Formulae (linha de comando)
# ------------------------------------------------------------------
install_formulae() {
    log_step "Instalando formulae (htop, node)"
    brew install htop
    brew install node
}

# ------------------------------------------------------------------
# 2. Casks (apps e SDKs com GUI)
# ------------------------------------------------------------------
install_casks() {
    log_step "Instalando casks (apps e SDKs)"
    local casks=(
        google-chrome
        microsoft-edge
        visual-studio-code
        spotify
        cursor
        zed
        android-studio
        postman
        "oracle-jdk@${JAVA_VERSION}"
        flutter
        dotnet-sdk
        claude-code
    )
    for cask in "${casks[@]}"; do
        run_or_warn "cask: $cask" brew install --cask "$cask"
    done
}

# ------------------------------------------------------------------
# 3. Variáveis de ambiente no ~/.zshrc (idempotente)
# ------------------------------------------------------------------
setup_shell_rc() {
    log_step "Configurando variáveis de ambiente em $SHELL_RC"
    local marker="# >>> initial-config-macos.sh managed block >>>"
    local end_marker="# <<< initial-config-macos.sh managed block <<<"

    if grep -qF "$marker" "$SHELL_RC" 2>/dev/null; then
        log_warn "Bloco já existe em $SHELL_RC, pulando (edite manualmente se precisar atualizar)"
        return
    fi

    mkdir -p "$ANDROID_SDK_DIR"

    cat >> "$SHELL_RC" <<EOF

$marker
# Homebrew no PATH (Apple Silicon ou Intel)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "\$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "\$(/usr/local/bin/brew shellenv)"
fi

# Java Home (via ferramenta oficial da Apple - resolve o cask oracle-jdk)
export JAVA_HOME=\$(/usr/libexec/java_home -v ${JAVA_VERSION} 2>/dev/null)

# Android Studio Home (local padrão do SDK no macOS)
export ANDROID_HOME=\$HOME/Library/Android/sdk
export PATH=\$PATH:\$ANDROID_HOME/emulator
export PATH=\$PATH:\$ANDROID_HOME/platform-tools
export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin

# DotNet home (cask dotnet-sdk usa o instalador oficial da Microsoft)
export DOTNET_ROOT=/usr/local/share/dotnet
export PATH=\$PATH:\$DOTNET_ROOT

# Flutter e NodeJS não precisam de HOME manual: o Homebrew já expõe
# os binários em \$(brew --prefix)/bin, que entra no PATH via "brew shellenv" acima.
$end_marker
EOF
    log_ok "Bloco adicionado em $SHELL_RC"
}

# ------------------------------------------------------------------
# Main
# ------------------------------------------------------------------
main() {
    run_or_warn "Homebrew"              install_homebrew
    run_or_warn "Formulae"              install_formulae
    run_or_warn "Casks"                 install_casks
    run_or_warn "Configuração $SHELL_RC" setup_shell_rc

    echo -e "\n${GREEN}==================================================${NC}"
    echo -e "${GREEN}Instalação concluída!${NC}"
    echo "Rode: source ~/.zshrc"
    echo ""
    echo "Atualizações futuras: TUDO é feito com um comando só:"
    echo "  brew update && brew upgrade"
    echo ""
    echo "Verifique com: flutter doctor / java -version / node -v / dotnet --version"
    echo -e "${GREEN}==================================================${NC}\n"
}

main "$@"
