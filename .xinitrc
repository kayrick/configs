xset r rate 300 40

parcellite &
dropbox-cli start

AWESOME_CONFIG=$HOME/.config/awesome/rc.lua
XBINDKEYS_CONFIG=${HOME}/.xbindkeysrc

setxkbmap -layout 'us,ru' -option 'grp:caps_toggle,grp_led:scroll'

. ~/.xinitrc.local

xbindkeys -f ${XBINDKEYS_CONFIG} &

mpd ~/.mpd.conf
mpc stop

exec /usr/bin/awesome --config ${AWESOME_CONFIG}
