#!/usr/bin/env bash
NAME=idea
PORT=10000
WAIT=5

if [ ! "$(docker ps -q -f name=$NAME)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=$NAME)" ]; then
    echo "Starting existing idea config..."
    docker start $NAME
    sleep $WAIT
    open http://localhost:$PORT
    exit 0
  fi
  echo "Starting new idea config..."
  docker run \
    -d \
    --name $NAME \
    -p $PORT:32000 \
    -p 8080:8080 \
    -p 8000:8000 \
    -p 8001:8001 \
    -p 5901:5901 \
    -e AUTH=${AUTH:-false} \
    -e JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64 \
    -e USERNAME=user \
    -e PASSWORD=s3cr3t \
    -e WIDTH=1920 \
    -e HEIGHT=1080 \
    -e PUID=503 \
    -e PGID=20 \
    -v ${HOME}/dev:/project \
    -v "${HOME}/.m2:/config/.m2" \
    -v ${HOME}/.config/ivonet/docker/JetBrains/IntelliJ_2021.1.3/cache:/config/.cache/JetBrains \
    -v ${HOME}/.config/ivonet/docker/JetBrains/IntelliJ_2021.1.3/config:/config/.config/JetBrains \
    -v ${HOME}/.config/ivonet/docker/JetBrains/IntelliJ_2021.1.3/local:/config/.local/share/Jetbrains \
    ivonet/intellij:2021.1.3

  sleep $WAIT
  open http://localhost:$PORT
else
  echo "Stopping idea..."
  docker stop $NAME
fi
