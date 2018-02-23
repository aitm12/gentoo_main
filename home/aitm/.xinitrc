# Screen Reso
xrandr --output VGA-1 --mode 1600x900

# pulseaudio
/usr/bin/start-pulseaudio-x11 &

# Xresources
xrdb -merge ~/.Xresources &

# awesome wm
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session awesome

# xfce4
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xfce4-session
