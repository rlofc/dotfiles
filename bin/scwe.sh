#!/bin/bash
t=$(mktemp -t savestdin.XXXXXXXXX) || exit
trap 'rm -f "$t"' EXIT
cat >"$t"
f="$(mktemp).wav"
pid=$(ffmpeg -f pulse -i default -ar 16000 -t 30 -y "$f" &> /dev/null & echo $!)
Xdialog --wmclass "hexroll3-app" --ok-label "Stop" --msgbox "Recording..." 20 80 &> /dev/null
kill "$pid" &> /dev/null
pid=$(Xdialog --wmclass "hexroll3-app" --no-buttons --infobox "Standby..." 20 80 30000 &> /dev/null & echo $!)
sleep 1 &> /dev/null
msg=$(/files/bin/whisper/whisper.cpp/build/bin/whisper-cli -m /files/bin/whisper/whisper.cpp/models/ggml-base.bin -t 8 -f "$f" -np -nt  | tail -1 | tr -d '\n' | awk '{$1=$1};1')
kill "$pid" &> /dev/null
# prompt=$(echo "$msg"  | fold -w 80 -s | Xdialog --stdout --wmclass "hexroll3-app" --ok-label "Send" --cancel-label "Cancel" --editbox /dev/stdin 20 80)
# prompt=$(tr '\n' ' ' <<< "$prompt")
# prompt=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' <<< "$prompt")
#if [ -n "${prompt}" ]; then
msg=$(tr '\n' ' ' <<< "$msg")
msg=$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' <<< "$msg")
if (echo "$msg"  | fold -w 80 -s | Xdialog --stdout --wmclass "hexroll3-app" --ok-label "Send" --cancel-label "Cancel" --textbox /dev/stdin 20 80) ; then
  prompt="$msg"
  rm "$f" &> /dev/null
  printf "<<<<<<< YOURS\n"
  cat $t
  echo "======="
  cat $t | sc "$prompt /nothink" | sed '/<think>/,/<\/think>/d' | sed '/./,$!d'
  printf "\n>>>>>>> ROBOT\n"
else
  cat $t
fi
