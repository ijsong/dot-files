# editor
export EDITOR=/usr/local/bin/vi

# go
export GOPATH=$HOME/workspaces
PATH=$GOPATH/bin:$PATH

# java
export JAVA_HOME=$(/usr/libexec/java_home)

# plenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# rbenv
eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# flutter
PATH=$HOME/workspaces/flutter/bin:$PATH

# scalikejdbc
PATH=${PATH}:${HOME}/bin/scalikejdbc-cli

# bash-git-prompt
# alternative: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  GIT_PROMPT_ONLY_IN_REPO=1
  GIT_PROMPT_SHOW_UNTRACKED_FILES=normal
  GIT_PROMPT_THEME=Default
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

# path
PATH=/usr/local/sbin:$PATH
export PATH=$PATH

# brew
alias brewall='brew update; brew cleanup; brew upgrade; brew doctor; brew cask doctor'

# bash_profile.d
for script in $HOME/dotfiles/bash_profile.d/*; do
  if [ -r $script ]; then
    source $script
  fi
done

# vi mode
set -o vi
