if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug"
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "zsh-users/zsh-completions"
zplug "modules/gpg", from:prezto
zplug "modules/git", from:prezto
zplug "modules/osx", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
zplug "modules/homebrew", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
zplug "plugins/mvn", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "jreese/zsh-titles"
zplug "psprint/zsh-select"
zplug "psprint/history-search-multi-word"
zplug "agkozak/agkozak-zsh-prompt"
zplug "aperezdc/zsh-fzy"
zplug "${ZDOTDIR:-$HOME}/.zshrc.osx", from:local, if:"[[ $OSTYPE == *darwin* ]]"
zplug "${ZDOTDIR:-$HOME}/.zshrc.msys", from:local, if:"[[ $OSTYPE == msys ]]"

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'

AGKOZAK_MULTILINE=0
AGKOZAK_CUSTOM_PROMPT='%(?..%B%F{red}(%?%)%f%b )'
AGKOZAK_CUSTOM_PROMPT+=$'%B%F{blue}%2v%f%b '
AGKOZAK_CUSTOM_PROMPT+='%F{magenta}%(4V.❮.❯)%f '

bindkey '\ec' fzy-cd-widget
bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget
bindkey '^P'  fzy-proc-widget

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

fpath=("${ZDOTDIR:-$HOME}/.zcustom/functions" $fpath)
autoload -U ${ZDOTDIR:-$HOME}/.zcustom/functions/*(:t)

eval "$(direnv hook zsh)"

git-svn-reintegrate-branch() {
  git checkout master && git svn rebase && git checkout "$1" && git rebase master && git checkout master && git merge "$1"
}