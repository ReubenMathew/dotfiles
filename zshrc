# Aliases
alias dc=docker-compose
alias run-help=man
alias which-command=whence
alias l='ls -l'
alias clx='clx -n'
alias e='$EDITOR $(gum file)'
alias f='$EDITOR $(gum filter)'
alias cat='bat -P'
alias a='vim ~/Developer/log/worklog/06-2023.md'
alias ag='git -C ~/Developer/log/ commit -a -m "entry" && git -C ~/Developer/log push'


# Variables
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export GOPATH=/Users/reubenninan/go

# PATH
export PATH=/Users/reubenninan/.krew/bin:/Users/reubenninan/.gem/ruby/3.1.3/bin:/Users/reubenninan/.rubies/ruby-3.1.3/lib/ruby/gems/3.1.0/bin:/Users/reubenninan/.rubies/ruby-3.1.3/bin:/usr/local/opt/llvm/bin:/Users/reubenninan/go/bin:/Library/Frameworks/Python.framework/Versions/3.9/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Library/Apple/usr/bin:/Users/reubenninan/.cargo/bin:/Users/reubenninan/bin

# Starship
eval "$(starship init zsh)"
export STARSHIP_SHELL=zsh

# Ruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3

# Autocomplete
autoload -Uz compinit && compinit
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
ENABLE_CORRECTION="true"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Kubectl Autocomplete
source <(kubectl completion zsh)

# Misc
setopt NO_BEEP

# oh-my-zsh
#plugins=(
  #zsh-autosuggestions
  #npm
  #ruby
  #git
  #dotenv
  #zsh-syntax-highlighting
#)

source /opt/homebrew/opt/chruby/share/chruby/auto.sh
