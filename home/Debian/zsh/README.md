# Configuración de ZSH en Debian

## Instalación

```bash
# Actualizar repositorios
sudo apt update

# Instalar ZSH
sudo apt install zsh

# Instalar Oh My Zsh (framework para gestionar la configuración de ZSH)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Plugins Recomendados

1. **zsh-autosuggestions**:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

2. **zsh-syntax-highlighting**:
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Configuración Básica (.zshrc)

```bash
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Tema (puedes cambiarlo según tus preferencias)
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    composer
    npm
    sudo
)

source $ZSH/oh-my-zsh.sh

# Alias útiles
alias ll='ls -lah'
alias update='sudo apt update && sudo apt upgrade'
alias clean='sudo apt autoremove && sudo apt clean'
```