eval "$(starship init zsh)"


# aliases
alias reload-zsh='source ~/.zshrc'
alias edit-zsh='nvim ~/.zshrc'
alias edit-aerospace='nvim ~/.config/aerospace/aerospace.toml'
alias cdsch='cd ~/Documents/code/sch/'

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.0.2.jdk/Contents/Home/"
export PATH=$PATH:$JAVA_HOME/bin
export PATH=${PATH}:/usr/local/mysql/bin

alias l='lsd -la'
alias ls='lsd -la'
alias lsl='lsd -al'
alias lsa='lsd -a'
alias c='clear'
alias nfzf='nvim $(fzf)'
alias ltree='lsd --tree'
alias htop='sudo htop' 
alias rlogin='ssh selimd@rlogin.cs.vt.edu'
#alias sshcl='ssh ec2-user@($1)'
#alias sshcl='echo ec2-user@$1'
alias cdsch='cd ~/Documents/code/sch/'
alias cdcode='cd ~/Documents/code/'
alias sb-stop='brew services stop sketchybar'
alias sb-start='brew services start sketchybar'
alias sb-reload='sketchybar --reload'
alias cc='claude'
alias reload-herdr='herdr server reload-config'
alias rghc='runghc'
sshcl(){
  $1 "ec2-user@${1}"
}

rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

export PATH=$PATH:/Users/eudypte/.spicetify

source <(fzf -zsh)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.local/share/zsh/plugins/zsh-shift-select/zsh-shift-select.plugin.zsh

bindkey -M shift-select '^[[1;10D' shift-select::beginning-of-line
bindkey -M shift-select '^[[1;10C' shift-select::end-of-line
bindkey -M emacs '^[[1;10D' shift-select::beginning-of-line
bindkey -M emacs '^[[1;10C' shift-select::end-of-line

export LS_COLORS="di=1;34:ln=36:so=35:pi=33:ex=1;31:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34:*.toml=36:*.yaml=36:*.yml=36:*.json=36:*.jsonc=36:*.ini=36:*.conf=36:*.cfg=36:*.env=36:*.lock=36:*.plist=36:*.xml=36:*.py=32:*.js=32:*.ts=32:*.jsx=32:*.tsx=32:*.c=32:*.h=32:*.cpp=32:*.hpp=32:*.java=32:*.rs=32:*.go=32:*.rb=32:*.lua=32:*.sh=32:*.zsh=32:*.bash=32:*.fish=32:*.swift=32:*.kt=32:*.css=32:*.scss=32:*.html=32:*.md=35:*.txt=35:*.rst=35:*.pdf=35:*.doc=35:*.docx=35:*.odt=35:*.tex=35:*.png=33:*.jpg=33:*.jpeg=33:*.gif=33:*.svg=33:*.webp=33:*.ico=33:*.heic=33:*.mp3=33:*.mp4=33:*.mov=33:*.wav=33:*.flac=33:*.zip=31:*.tar=31:*.gz=31:*.tgz=31:*.bz2=31:*.xz=31:*.7z=31:*.rar=31:*.dmg=31:*.pkg=31:*.log=90:*.bak=90:*.tmp=90:*.swp=90:*.orig=90"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/eudypte/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/eudypte/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/eudypte/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/eudypte/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/flex/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export OPENSKY_CLIENT_ID=$(jq -r .clientId ~/Documents/code/creds/credentials.json)
export OPENSKY_CLIENT_SECRET=$(jq -r .clientSecret ~/Documents/code/creds/credentials.json)
export MAPTILER_KEY=$(jq -r .maptilerKey ~/Documents/code/creds/credentials.json)

[ -f "/Users/eudypte/.ghcup/env" ] && . "/Users/eudypte/.ghcup/env" # ghcup-env
