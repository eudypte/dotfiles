eval "$(starship init zsh)"

# aliases
alias reload-zsh='source ~/.zshrc'
alias edit-zsh='nvim ~/.zshrc'

alias ls='lsd'
alias lsa='lsd -a'
alias cl='clear'
alias nfzf='nvim $(fzf)'
alias ltree='lsd --tree'



export PATH=$PATH:/Users/eudypte/.spicetify

#for macOS
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh

#for linux
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
