#!/usr/bin/env bash
# Requires wf-recorder: https://github.com/ammen99/wf-recorder

# Get the default audio sink
defaultSink=$(pactl get-default-sink)
WF_RECORDER_OPTS="--audio=$defaultSink.monitor -c libx264rgb"
outputFile=""
outputDir=""

# Function to check if recording is active
checkRecording() {
  pgrep -f "wf-recorder" >/dev/null
}

# Function to start screen recording
startRecording() {
  if checkRecording; then
    echo "A recording is already in progress."
    exit 1
  fi

  target="screen"

  # Set a default output directory if not provided
  outputDir="$HOME/Videos"

  mkdir -p $outputDir

  # Generate output filename and path
  outputFile="recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
  outputPath="$outputDir/$outputFile"

  # Start screen recording
  if [ "$target" == "screen" ]; then
    notify-send "Record Service" "Recording started" \
      -i video-x-generic \
      -a "Screen Recorder" \
      -t 10000

    wf-recorder $WF_RECORDER_OPTS --file "$outputPath" &
  elif [ "$target" == "region" ]; then
    wf-recorder $WF_RECORDER_OPTS --geometry "$(slurp)" --file "$outputPath" &
  fi

  disown "$(jobs -p | tail -n 1)"
  echo "Recording started. Saving to $outputPath"
  echo "$outputPath" >/tmp/last_recording_path
}

# Function to stop screen recording
stopRecording() {
  if ! checkRecording; then
    echo "No recording in progress."
    exit 1
  fi

  pkill -SIGINT -f wf-recorder
  sleep 1 # Allow wf-recorder time to terminate before proceeding

  outputPath=$(cat /tmp/last_recording_path 2>/dev/null)

  if [ -z "$outputPath" ] || [ ! -f "$outputPath" ]; then
    notify-send "Recording stopped" "No recent recording found." \
      -i video-x-generic \
      -a "Screen Recorder" \
      -t 10000
    exit 1
  fi

  notify-send "Recording stopped" "Saved to: $outputPath" \
    -i video-x-generic \
    -a "Screen Recorder" \
    -t 10000 \
    --action="scriptAction:-xdg-open $(dirname "$outputPath")=Open Directory" \
    --action="scriptAction:-xdg-open $outputPath=Play"
}

if checkRecording; then
  stopRecording
else
  startRecording
fi
