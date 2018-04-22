# Screen Reso
#xrandr --output VGA-1 --mode 1600x900

# Xresources
xrdb -merge ~/.Xresources &

# xfce4
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xfce4-session
