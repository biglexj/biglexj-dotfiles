# Configuración de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Corrección automática
ENABLE_CORRECTION="true"

# Tema vacío (personalizado)
ZSH_THEME=""

setopt prompt_subst
# Funciones personalizadas
function dir_icon {
    if [[ "$PWD" == "$HOME" ]]; then
        # Home
        echo "%{%B%F{white}%}%{%f%b%}"
    else
        # Carpeta
        echo "%{%B%F{cyan}%}%{%f%b%}"
    fi
}


function parse_git_branch {
	local branch
	branch=$(git symbolic-ref --short HEAD 2> /dev/null)
	if [ -n "$branch" ]; then
		echo " [$branch]"
	fi
}

# Habilitar vcs_info para mostrar rama de git
autoload -U add-zsh-hook
load-vcs-info() {
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git*' formats ' [%b]'
    zstyle ':vcs_info:git*' actionformats ' [%b|%a]'
    zstyle ':vcs_info:git*' check-for-changes true
}
add-zsh-hook precmd load-vcs-info

# PROMPT personalizado (corregido)
PROMPT='%F{cyan}󰣇 %f %F{magenta}%n%f $(dir_icon) %F{red}%~%f${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{green}.%F{red})%f%b '

# Plugins# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    sudo
    extract
    web-search
)
source $ZSH/oh-my-zsh.sh

# Colores de resaltado de sintaxis
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF4C70,bold'     # Color general
ZSH_HIGHLIGHT_STYLES[bad-command]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#00AAFF,bold'
ZSH_HIGHLIGHT_STYLES[command]=fg=#00F5CE,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=#00F5CE,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#00F5CE,bold

# Deshabilitar colores en ls
unset LS_COLORS
export LS_COLORS=""

# Alias
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rns'
alias installu='sudo pacman -U'
alias update='sudo pacman -Syu'
alias ..='cd ..'
alias ls='lsd'
alias ll='lsd -lh'
alias la='lsd -A'
alias lsa='lsd -lah'
alias lss='lsd -lh'
alias gc="git clone"
alias v="nvim"
alias zshconf="$EDITOR ~/.zshrc && source ~/.zshrc"

alias bj='cd /mnt/ntfs/'
alias bjd='/mnt/ntfs/Descargas'
alias bje='/mnt/ntfs/Documentos'
alias bji='/mnt/ntfs/Imágenes'
alias bjm='/mnt/ntfs/Música'
alias bjv='/mnt/ntfs/Videos'

# Path
export PATH=$PATH:/opt/Dev-Tools/SDK/Flutter/bin/
export JAVA_HOME=/opt/Dev-Tools/JDK/Java/jdk-21.0.7+6/
export PATH=$PATH:/opt/Dev-Tools/Build-Tools/Gradle/gradle-8.14.1/bin/
export ANDROID_SDK_ROOT=/opt/Dev-Tools/SDK/Android/
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/34.0.0
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias brave='brave --password-store=basic'

# Alias a Scripts
alias mountdisk='/mnt/files/Instaladores/Linux/Instrucciones/Scripts/mount.sh'
alias scrcpycn='/mnt/files/Instaladores/Linux/Instrucciones/Scripts/scrcpy-connect.sh'
export PATH=$PATH:/opt/microsoft/msedge/
fpath=(~/.zsh/completions $fpath)
