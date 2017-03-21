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

# hbase
export HBASE_HOME=$HOME/bin/hbase
PATH=$HBASE_HOME/bin:$PATH

# arcanist
PATH=$HOME/workspaces/arcanist/bin:$PATH

# bash-git-prompt
if [ -f /usr/local/share/gitprompt.sh ]; then
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
for script in $HOME/bash_profile.d/*; do
	if [ -r $script ]; then
		source $script
	fi
done

