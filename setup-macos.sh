#!/bin/bash

# Solicita a senha do sudo antecipadamente
sudo -v

# Verifica se a autenticação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Autenticação bem-sucedida. Continuando a execução do script..."
else
    echo "Falha na autenticação. Certifique-se de fornecer a senha correta."
    exit 1
fi

# Instala Homebrew, se ainda não estiver instalado
if ! command -v brew &> /dev/null; then
    echo "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update

# Instala Zsh
if ! command -v zsh &> /dev/null; then
    echo "Instalando Zsh..."
    brew install zsh
fi

# Instala Curl
if ! command -v curl &> /dev/null; then
    echo "Instalando Curl..."
    brew install curl
fi

# Instala Git
if ! command -v git &> /dev/null; then
    echo "Instalando Git..."
    brew install git
fi

# Configuração do Git com seu nome e email
echo "Configurando Git com nome de usuário e email..."
git config --global user.name "SEU_NOME"
git config --global user.email "seu.email@exemplo.com"

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
nvm alias default lts/*

# Instala Yarn
echo "Instalando Yarn..."
brew install yarn

# Instala Docker Desktop
echo "Instalando Docker Desktop..."
brew install --cask docker

# Instala VSCode
echo "Instalando Visual Studio Code..."
brew install --cask visual-studio-code

# Gera a chave SSH
echo "Gerando chave SSH..."
ssh-keygen -t rsa -b 4096 -C "seu.email@exemplo.com"

# Inicia o agente SSH
eval "$(ssh-agent -s)"

# Adiciona a chave ao agente SSH
ssh-add -K ~/.ssh/id_rsa

# Exibe a chave pública
echo "A chave pública SSH foi gerada. Copie a saída abaixo e adicione-a ao GitHub (https://github.com/settings/ssh/new):"
echo ""
cat ~/.ssh/id_rsa.pub
echo ""

read -p "Após adicionar a chave ao GitHub, pressione Enter para continuar..."

# Instala Oh My Zsh
echo "Instalando Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instala Powerline fonts
echo "Instalando fontes Powerline..."
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

# Muda tema para Agnoster
echo "Configurando tema Agnoster..."
sed -i '' 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc

# Define Zsh como shell padrão
echo "Definindo Zsh como shell padrão..."
chsh -s $(which zsh)

echo "✅ Setup concluído! Reinicie seu terminal (ou computador) para aplicar todas as mudanças."

