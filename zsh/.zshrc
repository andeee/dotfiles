### Added by Zplugin's installer
source "${ZDOTDIR:-$HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zstyle ':prezto:*:*' color 'yes'

zplugin ice svn silent; zplugin snippet PZT::modules/environment
zplugin ice svn silent; zplugin snippet PZT::modules/terminal
zplugin ice svn silent; zplugin snippet PZT::modules/history
zplugin ice svn silent; zplugin snippet PZT::modules/completion
zplugin ice svn silent; zplugin snippet PZT::modules/git

zstyle ':prezto:module:editor' key-bindings 'emacs'
zplugin ice svn silent; zplugin snippet PZT::modules/editor

zplugin ice svn silent; zplugin snippet PZT::modules/directory
zplugin ice svn silent; zplugin snippet PZT::modules/spectrum
zplugin ice svn silent; zplugin snippet PZT::modules/utility
zplugin ice svn silent; zplugin snippet OMZ::plugins/mvn

zplugin light "zsh-users/zsh-completions"
zplugin light "zsh-users/zsh-autosuggestions"

autoload compinit
compinit

zplugin light "agkozak/agkozak-zsh-prompt"
zplugin light "zsh-users/zsh-history-substring-search"
zplugin light "zdharma/fast-syntax-highlighting"
zplugin light "psprint/zsh-select"
zplugin light "psprint/history-search-multi-word"

if [[ $OSTYPE == *darwin* ]]; then
    zplugin ice svn silent; zplugin snippet PZT::modules/osx
    zplugin ice svn silent; zplugin snippet PZT::modules/homebrew
    source "${ZDOTDIR:-$HOME}/.zshrc.osx"
fi

if [[ $OSTYPE == msys ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc.msys"
fi

AGKOZAK_MULTILINE=0
AGKOZAK_CUSTOM_PROMPT='%(?..%B%F{red}(%?%)%f%b )'
AGKOZAK_CUSTOM_PROMPT+=$'%B%F{blue}%2v%f%b '
AGKOZAK_CUSTOM_PROMPT+='%F{magenta}%(4V.❮.❯)%f '

CUSTOM_FUNCTIONS_DIR="${ZDOTDIR:-$HOME}/.zcustom/functions"

if [[ -d "${CUSTOM_FUNCTIONS_DIR}" ]]; then
    fpath=("${CUSTOM_FUNCTIONS_DIR}" $fpath)
    autoload -U ${CUSTOM_FUNCTIONS_DIR}/*(:t)
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

git-svn-reintegrate-branch() {
  git checkout master && git svn rebase && git checkout "$1" && git rebase master && git checkout master && git merge "$1"
}