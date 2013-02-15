#!/bin/bash

MP3="./harlem-shake.mp3"

trap cleanup INT
function cleanup() {
  kill $PID_AFPLAY > /dev/null 2>&1
  kill $PID_RAINBOW > /dev/null 2>&1
  sleep 1
  blink1-tool --off --quiet
  exit
}

afplay $MP3 & PID_AFPLAY=$!
sleep 2.5
blink1-tool --blink 32 --millis 100 --delay 210 --quiet

function rainbow() {
  while true
  do
    DELAY=`jot -r 20 70`
    FADE=`jot -r 10 20`
    blink1-tool --random 10 --millis $FADE --delay $DELAY --quiet
  done
}

rainbow & PID_RAINBOW=$!
sleep 12.5
kill $PID_RAINBOW
blink1-tool --blink 1 --millis 1000 --quiet
