#!/usr/bin/env bash

HUB=ivonet
HUB=192.168.2.3:5555


docker run                             \
    -it                                \
    --rm                               \
    --name idea                        \
    -p 32000:32000                     \
    -p 8080:8080                       \
    -e AUTH=${AUTH:-false}             \
    -e WIDTH=1920                      \
    -e HEIGHT=1080                     \
    -v $(pwd)/:/project                \
    -v "/Users/ivonet/.m2:/root/.m2"   \
    -v /Users/ivonet/.config/ivonet/docker/IntelliJIdea2019.1:/nobody/.IntelliJIdea2019.1 \
    ${HUB}/intellij
