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
colors=(Black Maroon Green1 Olive Navy Purple Teal Silver 
Grey Red Lime Yellow Blue Fuchsia Aqua White 
Grey0 NavyBlue DarkBlue Blue3 Blue3 Blue1 DarkGreen DeepSkyBlue4 
DeepSkyBlue4 DeepSkyBlue4 DodgerBlue3 DodgerBlue2 Green4 SpringGreen4 Turquoise4 DeepSkyBlue3 
DeepSkyBlue3 DodgerBlue1 Green3 SpringGreen3 DarkCyan LightSeaGreen DeepSkyBlue2 DeepSkyBlue1 
Green3 SpringGreen3 SpringGreen2 Cyan3 DarkTurquoise Turquoise2 Green1 SpringGreen2 
SpringGreen1 MediumSpringGreen Cyan2 Cyan1 DarkRed DeepPink4 Purple4 Purple4 
Purple3 BlueViolet Orange4 Grey37 MediumPurple4 SlateBlue3 SlateBlue3 RoyalBlue1 
Chartreuse4 DarkSeaGreen4 PaleTurquoise4 SteelBlue SteelBlue3 CornflowerBlue Chartreuse3 DarkSeaGreen4 
CadetBlue CadetBlue SkyBlue3 SteelBlue1 Chartreuse3 PaleGreen3 SeaGreen3 Aquamarine3 
MediumTurquoise SteelBlue1 Chartreuse2 SeaGreen2 SeaGreen1 SeaGreen1 Aquamarine1 DarkSlateGray2 
DarkRed DeepPink4 DarkMagenta DarkMagenta DarkViolet Purple Orange4 LightPink4 
Plum4 MediumPurple3 MediumPurple3 SlateBlue1 Yellow4 Wheat4 Grey53 LightSlateGrey 
MediumPurple LightSlateBlue Yellow4 DarkOliveGreen3 DarkSeaGreen LightSkyBlue3 LightSkyBlue3 SkyBlue2 
Chartreuse2 DarkOliveGreen3 PaleGreen3 DarkSeaGreen3 DarkSlateGray3 SkyBlue1 Chartreuse1 LightGreen 
LightGreen PaleGreen1 Aquamarine1 DarkSlateGray1 Red3 DeepPink4 MediumVioletRed Magenta3 
DarkViolet Purple DarkOrange3 IndianRed HotPink3 MediumOrchid3 MediumOrchid MediumPurple2 
DarkGoldenrod LightSalmon3 RosyBrown Grey63 MediumPurple2 MediumPurple1 Gold3 DarkKhaki 
NavajoWhite3 Grey69 LightSteelBlue3 LightSteelBlue Yellow3 DarkOliveGreen3 DarkSeaGreen3 DarkSeaGreen2 
LightCyan3 LightSkyBlue1 GreenYellow DarkOliveGreen2 PaleGreen1 DarkSeaGreen2 DarkSeaGreen1 PaleTurquoise1 
Red3 DeepPink3 DeepPink3 Magenta3 Magenta3 Magenta2 DarkOrange3 IndianRed 
HotPink3 HotPink2 Orchid MediumOrchid1 Orange3 LightSalmon3 LightPink3 Pink3 
Plum3 Violet Gold3 LightGoldenrod3 Tan MistyRose3 Thistle3 Plum2 
Yellow3 Khaki3 LightGoldenrod2 LightYellow3 Grey84 LightSteelBlue1 Yellow2 DarkOliveGreen1 
DarkOliveGreen1 DarkSeaGreen1 Honeydew2 LightCyan1 Red1 DeepPink2 DeepPink1 DeepPink1 
Magenta2 Magenta1 OrangeRed1 IndianRed1 IndianRed1 HotPink HotPink MediumOrchid1 
DarkOrange Salmon1 LightCoral PaleVioletRed1 Orchid2 Orchid1 Orange1 SandyBrown 
LightSalmon1 LightPink1 Pink1 Plum1 Gold1 LightGoldenrod2 LightGoldenrod2 NavajoWhite1 
MistyRose1 Thistle1 Yellow1 LightGoldenrod1 Khaki1 Wheat1 Cornsilk1 Grey100 
Grey3 Grey7 Grey11 Grey15 Grey19 Grey23 Grey27 Grey30 
Grey35 Grey39 Grey42 Grey46 Grey50 Grey54 Grey58 Grey62 
Grey66 Grey70 Grey74 Grey78 Grey82 Grey85 Grey89 Grey93)
for color in {0..255}; do
  index=$(( $color + 1 ))
  SFG[$colors[$index]]='\o033'"[38;5;${color}m"
  SBG[$colors[$index]]='\o033'"[48;5;${color}m"
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
        -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/Tests run: ${SFG[Green1]}\1${SFG[none]}, Failures: ${SFG[Yellow1]}\2${SFG[none]}, Errors: ${SFG[Red1]}\3${SFG[none]}, Skipped: ${SFG[Cyan1]}\4${SFG[none]}/g" \
        -e "s/\(\[\{0,1\}WARN\(ING\)\{0,1\}\]\{0,1\}.*\)/${SFG[Yellow1]}\1${SFG[none]}/g" \
        -e "s/\(\[\{0,1\}ERROR\]\{0,1\}.*\)/${SFG[Red1]}\1${SFG[none]}/g" \
        -e "s/\(\(BUILD \)\{0,1\}FAILURE.*\)/${SFG[Red1]}\1${SFG[none]}/g" \
        -e "s/\(\(BUILD \)\{0,1\}SUCCESS.*\)/${SFG[Green1]}\1${SFG[none]}/g" \
        -e "s/\(---.*---\|T E S T S.*\)/${SFG[Cyan1]}\1${SFG[none]}/g" \
        -e "/\.jar/! s/\(Building .*\)/${SFG[Cyan1]}\1${SFG[none]}/g"
    return $PIPESTATUS
}

# aliases
alias mvn=color_maven