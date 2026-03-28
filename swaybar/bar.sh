#!/bin/sh

print_block() {
  printf '{"full_text":"%s"}' "$1"
}

echo '{"version":1}'
echo '['
echo '[]'

while true; do
  # --- Player ---
  PLAYER=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)
  [ -z "$PLAYER" ] && PLAYER="No music"

  # --- Volume ---
  vol_float=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
  vol_percent=$(awk -v v="$vol_float" 'BEGIN { printf "%d", v*100 }')
  mute_state=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o 'MUTED')

  if [ "$mute_state" = "MUTED" ]; then
    VOL="󰟎 muted"
  else
    VOL="󰋋 $vol_percent%"
  fi

  # --- IP ---
  ip=$(hostname -I | awk '{print $1}')
  [ -z "$ip" ] && ip="no net"

  # --- Disk ---
  disk=$(df / -h | awk 'END{print $4}')

  # --- Date ---
  date_str=$(date "+ %a-%b-%d %I:%M %p")

  # --- Output (NO trailing commas) ---
  printf ',['
  print_block "$PLAYER"; printf ','
  print_block "$VOL"; printf ','
  print_block "$ip"; printf ','
  print_block " $disk"; printf ','
  print_block "$date_str"
  printf ']'

  sleep 1
done
