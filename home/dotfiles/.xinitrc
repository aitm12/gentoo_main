# update xresources
xrdb -merge ~/.Xresources &

# start tint2
#tint2 &

# zsh
chsh -s /bin/zsh &

# screensaver 
xautolock -time 10 -corners -000 -locker "xlock -mode matrix" &

# background with feh
#feh --bg-fill /home/aitm/images/gentoo.png 
/home/aitm/images/netrino.jpg 

# start xbindkeys
xbindkeys &

# conky
#conky &

## start a window manager
## uncomment either one

#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session herbstluftwm
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xfce4-session
