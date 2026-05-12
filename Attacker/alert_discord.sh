#!/usr/bin/env bash

HOST_RECEIVER_URL="http://192.168.56.1:9000/alert"
ALERT_FILE="/var/log/snort/alert_fast.txt"

HOSTNAME="$(hostname)"
SERVER_IP="$(hostname -I | awk '{print $1}')"

tail -F "$ALERT_FILE" | while read -r line; do
    [ -z "$line" ] && continue

    echo "$line" | grep -q "\[\*\*\]" || continue

    MESSAGE="Snort Alert Detected
Host: $HOSTNAME
Server IP: $SERVER_IP

$line"

    curl -s -X POST "$HOST_RECEIVER_URL" \
      --data-urlencode "alert=$MESSAGE" \
      > /tmp/snort_discord_forward_response.log
done