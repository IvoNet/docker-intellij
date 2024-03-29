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
    -e JAVA_HOME=/usr/lib/jvm/java-21-openjdk \
    -e USERNAME=user \
    -e PASSWORD=s3cr3t \
    -e WIDTH=1920 \
    -e HEIGHT=1080 \
    -e PUID=503 \
    -e PGID=20 \
    -v ${HOME}/dev:/project \
    -v "${HOME}/.m2:/config/.m2" \
    -v $(pwd)/.tmp/config/:/config/ \
    ivonet/intellij:latest
  sleep $WAIT
  open http://localhost:$PORT

  docker logs idea -f
  docker rm -f idea

else
  echo "Stopping idea..."
  docker stop $NAME
fi
