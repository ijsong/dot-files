# lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# editor
alias vim="nvim"
alias vi="nvim"
export EDITOR='nvim'

# llvm
PATH="/usr/local/opt/llvm/bin:$PATH"
LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
CPPFLAGS="-I/usr/local/opt/llvm/include"

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

# path
PATH=/usr/local/sbin:$PATH
export PATH=$PATH

# brew
alias brewall='brew update; brew cleanup; brew upgrade; brew upgrade --cask; brew doctor --verbose'

# vi mode
set -o vi

for f in $(find $HOME/bash_profile.d -type f); do
	source $f
done
