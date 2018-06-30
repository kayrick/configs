xset r rate 300 40

parcellite &
which dropbox && dropbox start

AWESOME_CONFIG=$HOME/.config/awesome/rc.lua
XBINDKEYS_CONFIG=${HOME}/.xbindkeysrc

setxkbmap -layout 'us,ru' -option 'grp:caps_toggle,grp_led:scroll'

. ~/.xinitrc.local

xbindkeys -f ${XBINDKEYS_CONFIG} &

xrdb ~/.Xdefaults

exec /usr/bin/awesome --config ${AWESOME_CONFIG}
