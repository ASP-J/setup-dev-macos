#!/bin/bash

# Script de setup para Linux
# Nota: Alguns comandos podem solicitar sua senha sudo durante a execução

# Instala dependências básicas do sistema
echo "Instalando dependências básicas..."
sudo apt-get update
sudo apt-get install -y build-essential curl git zsh wget gpg

# Verifica se Zsh está instalado (já instalado acima, mas verificamos)
if ! command -v zsh &> /dev/null; then
    echo "Instalando Zsh..."
    sudo apt-get install -y zsh
fi

# Verifica se Curl está instalado (já instalado acima, mas verificamos)
if ! command -v curl &> /dev/null; then
    echo "Instalando Curl..."
    sudo apt-get install -y curl
fi

# Verifica se Git está instalado (já instalado acima, mas verificamos)
if ! command -v git &> /dev/null; then
    echo "Instalando Git..."
    sudo apt-get install -y git
fi

# Configuração do Git com seu nome e email
echo "Configurando Git com nome de usuário e email..."
# Nota: Configure seu nome manualmente com: git config --global user.name "Seu Nome"
git config --global user.email "jmigotrski@gmail.com"

# Instala NVM
if [ ! -d "$HOME/.nvm" ]; then
    echo "Instalando NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Carrega NVM e instala Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Instalando Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default "lts/*"

# Instala Yarn
echo "Instalando Yarn..."
npm install -g yarn

# Instala Docker
echo "Instalando Docker..."
sudo apt-get install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Instala VSCode
echo "Instalando Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install -y code
rm packages.microsoft.gpg

# Instala Cursor
echo "Instalando Cursor..."
CURSOR_TEMP_DIR=$(mktemp -d)
cd "$CURSOR_TEMP_DIR"

# Tenta baixar o .deb do Cursor
ARCH=$(dpkg --print-architecture)
if [ "$ARCH" = "amd64" ]; then
    ARCH="x64"
elif [ "$ARCH" = "arm64" ]; then
    ARCH="arm64"
else
    ARCH="x64"
fi

# Baixa o Cursor (.deb primeiro)
wget -O cursor.deb "https://downloader.cursor.sh/linux/deb/${ARCH}" 2>/dev/null

if [ -f cursor.deb ]; then
    # Verifica se é um arquivo .deb válido
    if file cursor.deb 2>/dev/null | grep -q "Debian\|ar archive" || [ "${cursor.deb##*.}" = "deb" ]; then
        echo "Instalando Cursor via .deb..."
        sudo dpkg -i cursor.deb || sudo apt-get install -f -y
    else
        # Se não for .deb, tenta como AppImage
        echo "Instalando Cursor como AppImage..."
        chmod +x cursor.deb
        mkdir -p ~/.local/bin
        mv cursor.deb ~/.local/bin/cursor
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        echo "Cursor instalado como AppImage em ~/.local/bin/cursor"
    fi
else
    # Tenta baixar AppImage diretamente
    echo "Tentando baixar Cursor como AppImage..."
    wget -O cursor.AppImage "https://downloader.cursor.sh/linux/appImage/${ARCH}" 2>/dev/null
    if [ -f cursor.AppImage ]; then
        chmod +x cursor.AppImage
        mkdir -p ~/.local/bin
        mv cursor.AppImage ~/.local/bin/cursor
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        echo "Cursor instalado como AppImage em ~/.local/bin/cursor"
    else
        echo "Não foi possível baixar o Cursor automaticamente. Por favor, instale manualmente de https://cursor.sh"
    fi
fi

cd ~
rm -rf "$CURSOR_TEMP_DIR"

# Gera a chave SSH (não-interativo)
echo "Gerando chave SSH..."
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -C "jmigotrski@gmail.com" -f ~/.ssh/id_rsa -N ""
fi

# Inicia o agente SSH
eval "$(ssh-agent -s)"

# Adiciona a chave ao agente SSH (Linux não usa -K)
ssh-add ~/.ssh/id_rsa

# Exibe a chave pública
echo "A chave pública SSH foi gerada. Copie a saída abaixo e adicione-a ao GitHub (https://github.com/settings/ssh/new):"
echo ""
cat ~/.ssh/id_rsa.pub
echo ""

# Instala Oh My Zsh
echo "Instalando Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Clona repositório com configurações do .zshrc (comentado - você precisa fornecer o repositório)
# echo "Clonando repositório com configurações do .zshrc..."
# TEMP_DIR=$(mktemp -d)
# git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git "$TEMP_DIR"
# 
# # Verifica se o arquivo .zshrc existe no repositório
# if [ -f "$TEMP_DIR/.zshrc" ]; then
#     echo "Copiando configurações do .zshrc..."
#     cp "$TEMP_DIR/.zshrc" ~/.zshrc
#     echo "Arquivo .zshrc atualizado com as configurações do repositório."
# else
#     echo "Arquivo .zshrc não encontrado no repositório. Mantendo configurações padrão."
#     # Muda tema para Agnoster como fallback
#     sed -i 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc
# fi
# 
# # Limpa o diretório temporário
# rm -rf "$TEMP_DIR"

# Instala Powerline fonts
echo "Instalando fontes Powerline..."
# Instala fontes via apt
sudo apt-get install -y fonts-powerline
# Instala Meslo Nerd Font manualmente
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "Meslo LG S Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Regular/complete/Meslo%20LG%20S%20Regular%20Nerd%20Font%20Complete.ttf
curl -fLo "Meslo LG S Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Bold/complete/Meslo%20LG%20S%20Bold%20Nerd%20Font%20Complete.ttf
curl -fLo "Meslo LG S Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/Italic/complete/Meslo%20LG%20S%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Meslo LG S Bold Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/S/BoldItalic/complete/Meslo%20LG%20S%20Bold%20Italic%20Nerd%20Font%20Complete.ttf
fc-cache -f -v
cd ~

# Define Zsh como shell padrão
echo "Definindo Zsh como shell padrão..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

echo "✅ Setup concluído! Reinicie seu terminal (ou faça logout/login) para aplicar todas as mudanças."

