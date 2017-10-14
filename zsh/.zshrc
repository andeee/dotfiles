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
zplug "hkupty/ssh-agent"
zplug "modules/gpg", from:prezto
zplug "modules/prompt", from:prezto
zplug "modules/git", from:prezto
zplug "modules/ruby", from:prezto
zplug "modules/node", from:prezto
zplug "modules/osx", from:prezto
zplug "modules/homebrew", from:prezto
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "jreese/zsh-titles"
zplug "psprint/zsh-select"
zplug "psprint/history-search-multi-word"
zplug "~/.zshrc.osx", from:local, if:"[[ $OSTYPE == *darwin* ]]"
zplug "~/.zshrc.msys", from:local, if:"[[ $OSTYPE == msys ]]"

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:prompt' theme 'sorin'

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
