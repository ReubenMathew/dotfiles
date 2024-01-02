# Aliases
alias dc=docker-compose
alias run-help=man
alias which-command=whence
alias l='ls -l'
alias cdt='cd $(mktemp -d)'
alias chat='gum input | chatgpt -p '
alias python='python3'
alias a='cd ~/Developer/log && kitty @ set-tab-title Log && vim ~/Developer/log/worklog/01-2024.md'
alias ag='git commit -a -m "auto entry" && git push'
alias boot='glow ~/praathana.md'
alias ssh="kitty +kitten ssh"
alias nv="nvim"

# Variables
export EDITOR=/opt/homebrew/bin/vim
export VISUAL=/opt/homebrew/bin/vim
export GOPATH=/Users/reubenninan/go
export XDG_CONFIG_HOME=/Users/reubenninan/.config
export JAVA_HOME=$(/usr/libexec/java_home -v 18.0)

# PATH
export PATH="/Users/reubenninan/.krew/bin:/Users/reubenninan/.gem/ruby/3.1.3/bin:/Users/reubenninan/.rubies/ruby-3.1.3/lib/ruby/gems/3.1.0/bin:/Users/reubenninan/.rubies/ruby-3.1.3/bin:/usr/local/opt/llvm/bin:/Users/reubenninan/go/bin:/Library/Frameworks/Python.framework/Versions/3.9/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Library/Apple/usr/bin:/Users/reubenninan/.cargo/bin:/Users/reubenninan/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# Cmake
export PATH="/Applications/CMake.app/Contents/bin:$PATH"

# Starship
eval "$(starship init zsh)"
export STARSHIP_SHELL=zsh

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

# Kubectl Autocomplete;
source <(kubectl completion zsh)

# Misc
setopt NO_BEEP

# fuzzy-finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
