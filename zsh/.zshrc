source "$HOME/.zplugin/bin/zplugin.zsh"

zplugin ice svn silent; zplugin snippet PZT::modules/environment
zplugin ice svn silent; zplugin snippet PZT::modules/terminal
zplugin ice svn silent; zplugin snippet PZT::modules/history
zplugin ice svn silent; zplugin snippet PZT::modules/completion
zplugin ice svn silent; zplugin snippet PZT::modules/git
zplugin ice svn silent; zplugin snippet PZT::modules/editor
zplugin ice svn silent; zplugin snippet PZT::modules/directory
zplugin ice svn silent; zplugin snippet PZT::modules/spectrum
zplugin ice svn silent; zplugin snippet PZT::modules/utility
zplugin ice svn silent; zplugin snippet OMZ::plugins/mvn
zplugin light "zsh-users/zsh-completions"
zplugin light "agkozak/agkozak-zsh-prompt"
zplugin light "zsh-users/zsh-history-substring-search"
zplugin light "zsh-users/zsh-syntax-highlighting"
zplugin light "psprint/zsh-select"
zplugin light "psprint/history-search-multi-word"


# zplug "modules/gpg", from:prezto
# zplug "modules/osx", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
# zplug "modules/homebrew", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"

# zplug "${ZDOTDIR:-$HOME}/.zshrc.osx", from:local, if:"[[ $OSTYPE == *darwin* ]]"
# zplug "${ZDOTDIR:-$HOME}/.zshrc.msys", from:local, if:"[[ $OSTYPE == msys ]]"

zstyle ':prezto:*:*' color 'yes'
# zstyle ':prezto:module:editor' key-bindings 'emacs'

AGKOZAK_MULTILINE=0
AGKOZAK_CUSTOM_PROMPT='%(?..%B%F{red}(%?%)%f%b )'
AGKOZAK_CUSTOM_PROMPT+=$'%B%F{blue}%2v%f%b '
AGKOZAK_CUSTOM_PROMPT+='%F{magenta}%(4V.❮.❯)%f '

if [[ -d "${ZDOTDIR:-$HOME}/.zcustom/functions" ]]; then
    fpath=("${ZDOTDIR:-$HOME}/.zcustom/functions" $fpath)
    autoload -U ${ZDOTDIR:-$HOME}/.zcustom/functions/*(:t)
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

if [[ $OSTYPE == msys ]]; then
    zstyle ':completion:*' fake-files   '/:c' '/:d' '/:e' '/:x' '/:y' '/:z'
fi

git-svn-reintegrate-branch() {
  git checkout master && git svn rebase && git checkout "$1" && git rebase master && git checkout master && git merge "$1"
}