#!/usr/bin/env bash

HUB=ivonet
#HUB=192.168.2.3:5555


docker run                             \
    -it                                \
    --rm                               \
    --name idea                        \
    -p 32000:32000                     \
    -p 8080:8080                       \
    -p 5901:5901                       \
    -e AUTH=${AUTH:-false}             \
    -e WIDTH=1920                      \
    -e HEIGHT=1080                     \
    -v $(pwd)/:/project                \
    -v "${HOME}/.m2:/root/.m2"   \
    -v ${HOME}/.config/ivonet/docker/IntelliJIdea2019.3:/nobody/.IntelliJIdea2019.3 \
    ${HUB}/intellij
