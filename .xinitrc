xset r rate 300 40

xbindkeys &
parcellite &
dropbox-cli start

setxkbmap -layout 'us,ru' -option 'grp:caps_toggle,grp_led:scroll'

. ~/.xinitrc.local

mpd ~/.mpd.conf
mpc stop

exec /usr/bin/awesome
