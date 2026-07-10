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
alias rlogin='ssh selimd@vt.edu@rlogin.cs.vt.edu'
#alias sshcl='ssh ec2-user@($1)'
#alias sshcl='echo ec2-user@$1'
alias cdsch='cd ~/Documents/code/sch/'
alias sb-stop='brew services stop sketchybar'
alias sb-start='brew services start sketchybar'

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
