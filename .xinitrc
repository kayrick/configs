xset r rate 300 40

xbindkeys &
parcellite &

setxkbmap -layout 'us,ru' -option 'grp:caps_toggle,grp_led:scroll'

. ~/.xinitrc.local

exec /usr/bin/awesome
