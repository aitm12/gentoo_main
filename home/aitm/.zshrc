#! /bin/zsh

##
## ZSH SETTINGS ##
##
ZSH=/home/aitm/oh-my-zsh
ZSH_THEME="gentoo"

## portage completion
autoload -Uz compinit
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

# prompt
#prompt is in zsh_theme gentoo
autoload -Uz promptinit
promptinit

# avoid typing cd (/etc instead of cd /etc)
setopt auto_cd

# glob expansion
setopt extended_glob

# set case sensitive
CASE_SENSITIVE="true"

# disable bi-weekly updates
DISABLE_AUTO_UPDATE="true"

# red completion dots
COMPLETION_WAITING_DOTS="true"

# misc
plugins=(themes)
source /home/aitm/oh-my-zsh/oh-my-zsh.sh

# PATH
PATH="$HOME/.scripts:/opt/OpenCorsairLink:${PATH}"
export PATH

##
## PROGRAM STUFF ##
##

# default programs
export EDITOR="nano"
export PAGER="less"
export BROWSER="firefox-bin"
export BROWSERCLI="w3m"
export MOVPLAY="mplayer"
export AUDPLAY="alsaplayer"
export PICVIEW="feh"
export READER="mupdf"
export TERMINAL="URxvt"

# file extension
for ext in html org php com net; do alias -s $ext=$BROWSERCLI; done
for ext in txt texpy PKGBUILD; do alias -s $ext=$EDITOR; done
for ext in pdf; do alias -s $ext=$READER; done
for ext in png jpg jpeg gif tiff bmp svg; do alias -s $ext=$PICVIEW; done
for ext in mpg mp4 wmv avi mkv; do alias -s $ext=$MOVPLAY; done
for ext in mp3 flac wav raw wma aac; do alias -s $ext=$AUDPLAY; done


### cgroup stuff
###
for d in /sys/fs/cgroup/*; do
    f=$(basename $d)
    if [ "$f" = "unified" ]; then
        continue
    elif [ "$f" = "cpuset" ]; then
        echo 1 | sudo tee -a $d/cgroup.clone_children;
    elif [ "$f" = "memory" ]; then
        echo 1 | sudo tee -a $d/memory.use_hierarchy;
    fi
    sudo mkdir -p $d/$USER
    sudo chown -R $USER $d/$USER
    echo $$ > $d/$USER/tasks
done

##
### VARIABLES
##
USE=/etc/portage/package.use/
ACCEPT_KEYWORDS=/etc/portage/package.accept_keywords/
MASK=/etc/portage/package.mask/

##
## ALIAS ##
##

# sudo
alias sudo='sudo '

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
# cd into github dir, git pull
alias gitpull='git pull'
#
# 6. add to github repo, first cp files into dir.
alias gitadd='git add *'
# then commit "git commit -m <comment>"
alias gitcommit='gitcommit.sh'
# 7. finialize the github update
alias gitpush='git push origin master'
#

# FIREFOX #
alias firefox='apulse /opt/firefox/firefox-bin'

## display dmesg log
alias dmesg='sudo cat /var/log/dmesg'

## Portage
# emerge -ask -verbose
alias emerge="sudo emerge -av $@"
alias unmerge="sudo emerge -av --unmerge $@"
alias update='sudo emerge -av --newuse --update $@'
# update newuse
alias newuse="sudo emerge -av --update --newuse --deep @world"

# depclean
alias depclean="sudo emerge -av --depclean"
##

## actkbd daemon to toggle hotkeys numpad
# to find eventN > 'cat /proc/bus/input/devices'
alias numpadz='sudo actkbd -d /dev/input/event13 -D'
##
