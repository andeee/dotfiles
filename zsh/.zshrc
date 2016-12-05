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
zplug "modules/prompt", from:prezto
zplug "modules/git", from:prezto
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "jreese/zsh-titles"

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

if [[ "$OSTYPE" == msys ]]; then
   zstyle ':completion:*' fake-files   '/:c' '/:d' '/:e' '/:x' '/:y' '/:z'
fi

fpath=("${ZDOTDIR:-$HOME}/.zcustom/functions" $fpath)
autoload -U ${ZDOTDIR:-$HOME}/.zcustom/functions/*(:t)

if [[ "$OSTYPE" == msys ]]; then
  export SHELL=/usr/bin/zsh
fi

if [[ "$OSTYPE" == msys ]]; then
  alias scoop="powershell -noprofile -ex unrestricted scoop.ps1"
fi

source `which activate.sh`

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi