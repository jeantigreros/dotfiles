#!/bin/sh
 
common() {
echo -n "{"
echo -n "\"color\":\"#ffffff\","
echo -n "\"background\":\"$bg\","
echo -n "\"name\":\"$name\","
echo -n "\"full_text\":\" $stat\","
echo -n "},"
}
 
mydate() {
local name="id_time"
local stat=" $(date "+%a-%b-%d %I:%M %p")"
common
}
 
volume() {
    local name="id_volume"
    bg=""

    # Get volume as float (0–1)
    vol_float=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
    vol_percent=$(awk -v v="$vol_float" 'BEGIN { printf "%d", v*100 }')

    # Check mute state properly
    mute_state=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o 'MUTED')

    if [ "$mute_state" = "MUTED" ]; then
        bg="FF0000"
        stat=""
    else
        stat=" $vol_percent%"
    fi

    common
}

ipaddr() {
  local name="id_ip"
  # Get local IP (change interface if needed, e.g. wlan0)
  ip=$(hostname -I | awk '{print $1}')
  [ -z "$ip" ] && ip="no net"

  local stat="$ip"
  common
}

disk() {
    local name="id_disk"
    # Get disk usage percentage for root
    USAGE=$(df / -h | tail -1 | awk '{print $3}')
    local stat=" $USAGE"
    common
}

player() {
  local name="playerctl"
  PLAYER=$(playerctl metadata --format '{{artist}} - {{title}}')
  local stat="$PLAYER"
  common
}
 
echo '{ "version": 1 , "click_events":false}'
echo '[[],'
 
while :
do
echo -n "["
player
volume
ipaddr
disk
mydate
echo -n "],"
sleep 1
done
