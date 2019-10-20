# lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# editor
export EDITOR=/usr/local/bin/vi

# go
export GOPATH=$HOME/workspace
PATH=$GOPATH/bin:$PATH

# java
export JAVA_HOME=$(/usr/libexec/java_home)

# plenv
if which plenv > /dev/null; then eval "$(plenv init -)"; fi
if which plenv > /dev/null; then eval "$(plenv init - zsh)"; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# rbenv
eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-completion
fpath=(/usr/local/share/zsh-completions $fpath)

# zsh-git-prompt
source "/usr/local/opt/zsh-git-prompt/zshrc.sh"
PROMPT='%B%m%~%b$(git_super_status) %# '

# path
PATH=/usr/local/sbin:$PATH
export PATH=$PATH

# brew
alias brewall='brew update; brew cleanup; brew upgrade; brew cask upgrade; brew doctor; brew cask doctor'

# vi mode
set -o vi

# pyenv virtualenv
pyenv activate anaconda3-5.3.1
