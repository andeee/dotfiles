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

typeset -gA SFG SBG
# sed colors
SFG[none]='\o033[00m'
SBG[none]=${SFG[none]}
colors=(black red green yellow blue magenta cyan white)
for color in {0..255}; do
  if (( $color >= 0 )) && (( $color < $#colors )); then
    index=$(( $color + 1 ))
    SFG[$colors[$index]]='\o033'"[38;5;${color}m"
    SBG[$colors[$index]]='\o033'"[48;5;${color}m"
  fi

  SFG[$color]='\o033'"[38;5;${color}m"
  SBG[$color]='\o033'"[48;5;${color}m"
done
unset color{s,} index

# thanks to:  http://blog.blindgaenger.net/colorize_maven_output.html
# and: http://johannes.jakeapp.com/blog/category/fun-with-linux/200901/maven-colorized
# Colorize Maven Output
alias maven="command mvn"

function color_maven() {
    maven "$@" | sed \
        -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/Tests run: ${SFG[green]}\1${SFG[none]}, Failures: ${SFG[yellow]}\2${SFG[none]}, Errors: ${SFG[red]}\3${SFG[none]}, Skipped: ${SFG[cyan]}\4${SFG[none]}/g" \
        -e "s/\(\[\{0,1\}WARN\(ING\)\{0,1\}\]\{0,1\}.*\)/${SFG[yellow]}\1${SFG[none]}/g" \
        -e "s/\(\[\{0,1\}ERROR\]\{0,1\}.*\)/${SFG[red]}\1${SFG[none]}/g" \
        -e "s/\(\(BUILD \)\{0,1\}FAILURE.*\)/${SFG[red]}\1${SFG[none]}/g" \
        -e "s/\(\(BUILD \)\{0,1\}SUCCESS.*\)/${SFG[green]}\1${SFG[none]}/g" \
        -e "s/\(---.*---\|T E S T S.*\)/${SFG[cyan]}\1${SFG[none]}/g" \
        -e "/\.jar/! s/\(Building .*\)/${SFG[cyan]}\1${SFG[none]}/g"
    return $PIPESTATUS
}

# aliases
alias mvn=color_maven