xset r rate 300 40

xbindkeys &
parcellite --no-icon &

setxkbmap -layout 'us,ru' -option 'grp:caps_toggle,grp_led:scroll'

xset fp+ /usr/share/fonts/terminus/
exec /usr/bin/awesome
