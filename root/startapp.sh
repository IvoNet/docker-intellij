#!/usr/bin/env bash
# to make sure the application restarts when closed in the browser
while true
do
  cd /project || true
  /opt/idea/bin/idea.sh
done
