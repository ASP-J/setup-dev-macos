# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

alias gs='git stash'
alias gsp='git stash pop'

# Git Skip-Worktree Aliases
# Adicione estas linhas ao seu ~/.zshrc

# Lista dos arquivos para skip-worktree
SKIP_FILES=(
  "Dockerfile"
  "Gemfile"
  "Gemfile.lock"
  "app/helpers/application_helper.rb"
  "config/database.yml"
  "config/environment.rb"
  "config/environments/development.rb"
  "config/initializers/sidekiq.rb"
  # "db/migrate/20141126180335_create_group_participant_levels.rb"
  # "db/migrate/20230502140106_create_user_logs.rb"
  # "db/migrate/20230605205118_create_organization_subscription_stream_logs.rb"
  # "db/migrate/20240528180250_drop_group_participant_levels_table.rb"
  "config/initializers/datadog.rb"
)

# Função para aplicar skip-worktree
skip() {
  echo "🔒 Aplicando skip-worktree..."
  for file in "${SKIP_FILES[@]}"; do
    if [ -f "$file" ]; then
      git update-index --skip-worktree "$file"
      echo "✅ $file"
    fi
  done
  echo "✅ Skip-worktree aplicado!"
}

# Função para remover skip-worktree
noskip() {
  echo "🔓 Removendo skip-worktree..."
  for file in "${SKIP_FILES[@]}"; do
    if [ -f "$file" ]; then
      git update-index --no-skip-worktree "$file"
      echo "✅ $file"
    fi
  done
  echo "✅ Skip-worktree removido!"
}

# Função para verificar status
skipstatus() {
  echo "📋 Status skip-worktree:"
  for file in "${SKIP_FILES[@]}"; do
    if [ -f "$file" ]; then
      if git ls-files -v "$file" | grep -q "^S"; then
        echo "🔒 $file"
      else
        echo "🔓 $file"
      fi
    fi
  done
}

# Função para verificar status
skipstatus() {
  echo "📋 Status skip-worktree:"
  for file in "${SKIP_FILES[@]}"; do
    if [ -f "$file" ]; then
      if git ls-files -v "$file" | grep -q "^S"; then
        echo "🔒 $file"
      else
        echo "🔓 $file"
      fi
    fi
  done
}

# Função para trocar de branch (remove skip-worktree e faz stash)
trocarbranch() {
  echo "🔄 Preparando para trocar de branch..."
  
  # Remove skip-worktree
  echo "🔓 Removendo skip-worktree..."
  for file in "${SKIP_FILES[@]}"; do
    if [ -f "$file" ]; then
      git update-index --no-skip-worktree "$file"
      echo "✅ $file"
    fi
  done
  echo "✅ Skip-worktree removido!"
  
  # Faz git stash
  echo "📦 Fazendo git stash..."
  git stash
  echo "✅ Pronto para trocar de branch!"
}

# Função para voltar (faz stash pop e aplica skip-worktree)
voltarlocal() {
  echo "🔄 Voltando configurações locais..."
  
  # Faz git stash pop
  echo "📦 Fazendo git stash pop..."
  git stash pop
  
  # Aplica skip-worktree
  echo "🔒 Aplicando skip-worktree..."
  for file in "${SKIP_FILES[@]}"; do
    if [ -f "$file" ]; then
      git update-index --skip-worktree "$file"
      echo "✅ $file"
    fi
  done
  echo "✅ Skip-worktree aplicado!"
  echo "✅ Configurações locais restauradas!"
}

# =============================================================================
# TWYGO DEVELOPMENT ENVIRONMENT
# a

# Alias para iniciar ambiente de desenvolvimento Twygo no Warp
alias twygo="$HOME/Documents/scripts/twygo.sh"

# Alias para parar todos os serviços Twygo
alias twygo-stop="$HOME/Documents/scripts/twygo-stop.sh"

# Função para mostrar status dos serviços Twygo
twygo-status() {
  echo "📊 Status dos serviços Twygo:"
  echo ""
  
  # Verifica Rails
  if pgrep -f "rails s" > /dev/null; then
    echo "🚂 Rails Server: ✅ RODANDO"
  else
    echo "🚂 Rails Server: ❌ PARADO"
  fi
  
  # Verifica Vite
  if pgrep -f "vite" > /dev/null; then
    echo "📦 Vite Dev Server: ✅ RODANDO"
  else
    echo "📦 Vite Dev Server: ❌ PARADO"
  fi
  
  # Verifica Sidekiq
  if pgrep -f "sidekiq" > /dev/null; then
    echo "⚡ Sidekiq: ✅ RODANDO"
  else
    echo "⚡ Sidekiq: ❌ PARADO"
  fi
  
  # Verifica Docker
  if [ -f "$HOME/Documents/twyg-app/docker-compose.yml" ]; then
    cd "$HOME/Documents/twyg-app"
    if docker-compose ps | grep -q "Up"; then
      echo "🐳 Docker: ✅ RODANDO"
    else
      echo "🐳 Docker: ❌ PARADO"
    fi
  fi
  
  echo ""
  echo "💡 Para iniciar: twygo"
  echo "💡 Para parar: twygo-stop"
}

# Função para logs do Docker
twygo-logs() {
  echo "📊 Logs dos containers Docker..."
  cd "$HOME/Documents/twyg-app"
  docker-compose logs -f
}

# Função para ajuda sobre comandos Twygo
twygo-help() {
  echo "🚀 Comandos Twygo disponíveis:"
  echo ""
  echo "📦 twygo           - Inicia ambiente completo no Warp"
  echo "🛑 twygo-stop      - Para todos os serviços"
  echo "📊 twygo-status    - Mostra status dos serviços"
  echo "📋 twygo-logs      - Mostra logs do Docker"
  echo "❓ twygo-help      - Mostra esta ajuda"
  echo ""
  echo "🎯 Serviços iniciados:"
  echo "   📦 Vite Dev Server"
  echo "   🚂 Rails Server (http://localhost:3000)"
  echo "   ⚡ Sidekiq"
  echo "   🐳 Docker Compose"
} 