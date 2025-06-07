# Setup Dev macOS 🚀

Script automatizado para configuração de ambiente de desenvolvimento no macOS, incluindo ferramentas essenciais, configurações do terminal e aliases personalizados para Git.

## 📋 O que o script instala

### Ferramentas de desenvolvimento
- **Homebrew** - Gerenciador de pacotes para macOS
- **Zsh** - Shell avançado
- **Git** - Sistema de controle de versão
- **Curl** - Ferramenta de transferência de dados
- **NVM** - Gerenciador de versões do Node.js
- **Node.js LTS** - Runtime JavaScript
- **Yarn** - Gerenciador de pacotes JavaScript
- **Docker Desktop** - Plataforma de containerização
- **Visual Studio Code** - Editor de código

### Configurações do terminal
- **Oh My Zsh** - Framework para Zsh com plugins e temas
- **Fontes Powerline** - Fontes especiais para temas do terminal
- **Configurações personalizadas** do `.zshrc` com aliases úteis

### Segurança
- Geração automática de **chave SSH** para GitHub
- Configuração do **agente SSH**

## 🚀 Como usar

### 1. Clone o repositório
```bash
git clone https://github.com/SEU_USUARIO/setup-dev-macos.git
cd setup-dev-macos
```

### 2. Torne o script executável
```bash
chmod +x setup-macos.sh
```

### 3. Execute o script
```bash
./setup-macos.sh
```

### 4. Siga as instruções
O script irá:
- Solicitar sua senha do sistema
- Configurar o Git (você precisará editar nome/email)
- Gerar uma chave SSH (você precisará adicionar ao GitHub)
- Aplicar as configurações do terminal

## ⚙️ Configurações incluídas

### Aliases Git úteis
```bash
gs='git stash'              # Fazer stash rapidamente
gsp='git stash pop'         # Recuperar stash
```

### Sistema Skip-Worktree
Funções para gerenciar arquivos que não devem ser commitados:

```bash
skip           # Aplica skip-worktree nos arquivos configurados
noskip         # Remove skip-worktree
skipstatus     # Verifica status dos arquivos
trocarbranch   # Prepara para trocar de branch
voltarlocal    # Restaura configurações locais
```

### Ambiente Twygo (se aplicável)
```bash
twygo          # Inicia ambiente completo
twygo-stop     # Para todos os serviços
twygo-status   # Mostra status dos serviços
twygo-logs     # Mostra logs do Docker
twygo-help     # Ajuda dos comandos
```

## 🔧 Personalização

### Antes de executar o script

1. **Edite as informações do Git** no arquivo [`setup-macos.sh`](setup-macos.sh):
```bash
git config --global user.name "SEU_NOME"
git config --global user.email "seu.email@exemplo.com"
```

2. **Configure o repositório das configurações**:
```bash
git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git "$TEMP_DIR"
```

3. **Ajuste a lista de arquivos para skip-worktree** no arquivo [`.zshrc`](.zshrc) se necessário.

### Após a instalação

1. Adicione sua chave SSH pública ao GitHub em: https://github.com/settings/ssh/new
2. Reinicie o terminal ou execute: `source ~/.zshrc`
3. Configure seu terminal para usar a fonte **Meslo LG Nerd Font**

## 📁 Estrutura do projeto

```
setup-dev-macos/
├── README.md          # Este arquivo
├── setup-macos.sh     # Script principal de instalação
└── .zshrc            # Configurações do Zsh com aliases
```

## 🐛 Solução de problemas

### Erro de permissão
```bash
chmod +x setup-macos.sh
```

### Homebrew não encontrado após instalação
Adicione ao seu `.zprofile`:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Fontes não aparecem no terminal
Verifique se selecionou a fonte **Meslo LG Nerd Font** nas configurações do seu terminal.

### NVM não funciona
Reinicie o terminal ou execute:
```bash
source ~/.zshrc
```

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

## ✨ Funcionalidades futuras

- [ ] Instalação opcional de ferramentas
- [ ] Configuração automática de temas do VS Code
- [ ] Setup para diferentes linguagens de programação
- [ ] Backup automático de configurações existentes
- [ ] Suporte para diferentes shells (bash, fish)

---

**Feito com ❤️ para agilizar o setup de desenvolvimento no macOS**