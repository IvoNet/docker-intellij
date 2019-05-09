#!/usr/bin/env bash
NAME=idea
PORT=10000
WAIT=6

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
        --name $NAME                                               \
        -p $PORT:32000                                            \
        -p 8080:8080                                              \
        -v /Users/ivonet/dev/docker-web-gui-apps/intellij/projects:/project                               \
        -v "/Users/ivonet/.m2:/root/.m2"                          \
        -v ${HOME}/.config/ivonet/docker/IntelliJIdea2019.1:/nobody/.IntelliJIdea2019.1 \
        ivonet/intellij

    sleep $WAIT
    open http://localhost:$PORT
else
    echo "Stopping idea..."
    docker stop $NAME
fi
