#! /bin/zsh

##
## ZSH SETTINGS ##
##
ZSH=/home/aitm/oh-my-zsh
ZSH_THEME="robbyrussell"
## portage completion
autoload -U compinit
compinit

# correction
setopt correctall

# cache for completion
zstyle ':completion::complete:*' use-cache 1

# history
HISTSIZE=1000
HISTFILE="$HOME/.history"
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

# avoid typing cd (/etc instead of cd /etc)
setopt autocd

# set case sensitive
CASE_SENSITIVE="true"

# disable bi-weekly updates
DISABLE_AUTO_UPDATE="true"

# red completion dots
COMPLETION_WAITING_DOTS="true"

# PATH
PATH="$PATH:~/.scripts" 
export PATH
# misc
plugins=(themes)
source /home/aitm/oh-my-zsh/oh-my-zsh.sh
##
## PROGRAM STUFF ##
##

# default programs
export EDITOR="nano"
export PAGER="less"
export BROWSER="firefox-bin"
export BROWSERCLI="w3m"
export MOVPLAY="mplayer"
export PICVIEW="feh"
export READER="MuPDF"
export TERMINAL="URxvt"

# file extension
for ext in html org php com net; do alias -s $ext=$BROWSERCLI; done
for ext in txt texpy PKGBUILD; do alias -s $ext=$EDITOR; done
for ext in pdf; do alias -s $ext=$READER; done
for ext in png jpg gif; do alias -s $ext=$PICVIEW; done
for ext in mpg wmv avi mkv ; do alias -s $ext=$MOVPLAY; done


##
## ALIAS ##
##

# system alias
alias shutdown='sudo shutdown -P now'
alias reboot='sudo reboot'

# GIT #
#
# 1. git config --global user.name "<name>"
# 2. git config --global user.email "<email>"
#
# git aliases
#
# 3. cd into a dir
# 4. "git clone <https://github/com...git>"
alias gitclone='gitclone.sh'
#
# 5. to update local repository with github repo
#	cd into github dir, git pull
alias gitpull='git pull'
#
# 6. add to github repo, first cp files into dir.
alias gitadd='git add *'
# 	then commit "git commit -m <comment>"
alias gitcommit='gitcommit.sh'
# 7. finialize the github update
alias gitpush='git push origin master'
#

# FIREFOX #
alias firefox='apulse /opt/firefox/firefox-bin'
