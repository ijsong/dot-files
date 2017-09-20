# editor
export EDITOR=/usr/local/bin/vi

# go
export GOPATH=$HOME/workspaces
PATH=$GOPATH/bin:$PATH

# java
export JAVA_HOME=$(/usr/libexec/java_home)

# perlbrew
source ~/perl5/perlbrew/etc/bashrc

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# rbenv
eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# arcanist
PATH=$HOME/workspaces/arcanist/bin:$PATH

# bash-git-prompt
# alternative: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if [ -f /usr/local/share/gitprompt.sh ]; then
  GIT_PROMPT_ONLY_IN_REPO=1
  GIT_PROMPT_SHOW_UNTRACKED_FILES=normal
  GIT_PROMPT_THEME=Default
  . /usr/local/share/gitprompt.sh
fi

# coreutils
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# path
PATH=/usr/local/sbin:$PATH
export PATH=$PATH

# brew
alias brewall='brew update; brew cleanup; brew cask cleanup; brew upgrade; brew doctor; brew cask doctor'

# bash_profile.d
for script in $HOME/dotfiles/bash_profile.d/*; do
  if [ -r $script ]; then
    source $script
  fi
done

