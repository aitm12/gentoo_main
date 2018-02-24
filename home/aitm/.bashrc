# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
export PATH="$PATH:~/scripts"

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

###
### System Alias
alias shutdown='sudo shutdown -P now'
alias reboot='sudo reboot'

###
### Portage Alias
alias uworld='sudo emerge --ask --update --deep --jobs=6 --newuse @world'
alias emerge='sudo emerge --ask --verbose --jobs=6 $epackage'
alias depclean='sudo emerge --ask --jobs=6 --depclean'
alias oneshot='sudo emerge --ask --oneshot --jobs=6 portage'
alias esync='eix-sync'
alias eupdate='eix-update'
alias cdp='cd /etc/portage/'

###
### Git Alias
#cd into git dir
alias cdgit='cd ~/Downloads/gentoo_main'

# download gentoo_main repo into current dir
alias gitclone='git clone https://github.com/aitm12/gentoo_main.git'

#update local repository with github repository
#while cd in dir
alias gitpull='git pull'

# Steps to add into github repo
#1 add files to local repo before gitpull
alias gitadd='git add *'
#2 commit the changes
# but first create a label variable using commit_label
alias gitcommit='git commit -m $label'
#3 in case github repo not added
alias gitremoteadd='git remote add origin https://github.com/aitm12/gentoo_main.git'
#4 update github repo with local repo
# must be cd in repo dir
alias gitpush='git push origin master'


###
### Apulse Alias
alias firefox='apulse /opt/firefox/firefox-bin'
