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
    docker run                                                    \
        -d                                                        \
        --name $NAME                                              \
        -p $PORT:32000                                            \
        -p 8080:8080                                              \
        -p 5901:5901                                              \
        -e AUTH=${AUTH:-false}                                    \
        -e WIDTH=3440                                             \
        -e HEIGHT=1440                                            \
        -v ${HOME}/dev/docker-intellij/:/project                  \
        -v "${HOME}/.m2:/root/.m2"                                \
        -v ${HOME}/.config/ivonet/docker/JetBrains/IntelliJ/cache:/nobody/.cache/JetBrains \
        -v ${HOME}/.config/ivonet/docker/JetBrains/IntelliJ/config:/nobody/.config/JetBrains \
        -v ${HOME}/.config/ivonet/docker/JetBrains/IntelliJ/local:/nobody/.local \
        ivonet/intellij

    sleep $WAIT
    open http://localhost:$PORT
else
    echo "Stopping idea..."
    docker stop $NAME
fi
