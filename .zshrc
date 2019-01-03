#Use emacs key bindings
bindkey -e

# Utilites
PATH="${HOME}/.utility:$PATH"
# Global node modules
PATH="${HOME}/.node_modules/bin:$PATH"
# Rust
PATH="${HOME}/.cargo/bin:$PATH"

# Use ripgrep in fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# Fzf (Installed via NeoVim)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/getantibody/antibody/issues/68
setopt PROMPT_SUBST

#Load Antibody
source <(antibody init)
antibody bundle < ~/.zsh/zsh_plugins.txt

# Faster static loading
#source ~/.zsh/zsh_plugins.sh

# Alias
alias vc="nvim ~/.config/nvim/init.vim"
alias zc="nvim ~/.zshrc"
alias wifi="nmcli d wifi"

# functions
view() {
    if [ "$1" != "" ] 
    then
        mupdf-gl "$1" > /dev/null 2>&1 &
    fi
}

#Setup basic ZSH options
HISTSIZE=100
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
setopt extendedglob

#Setup tab-completion
fpath=(~/.zsh/completion $fpath)

#autoload -Uz compinit && compinit -i
#refresh cache every 24 hours
autoload -Uz compinit 
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;
zstyle ':completion:*' menu select

#Declare our keybindings
bindkey -M emacs '^[[A' history-substring-search-up     # Up Arrow: Triggers history substring match backwards (later)
bindkey -M emacs '^[[B' history-substring-search-down   #Down Arrow: Triggers history substring match forwards (earlier)

export PULSE_SERVER=unix:/tmp/pulse-PKdhtXMmr18n/native

# Print neofetch config on load
neofetch --ascii ~/.config/neofetch/ascii/void
