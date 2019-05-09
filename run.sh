#!/usr/bin/env bash

docker run                                                    \
    -it                                                       \
    --rm                                                      \
    --name idea                                               \
    -p 32000:32000                                            \
    -p 8080:8080                                              \
    -v $(pwd):/projects                                       \
    -v "/Users/ivonet/.m2:/root/.m2"                          \
    -v $(pwd)/.IntelliJIdea2019.1:/nobody/.IntelliJIdea2019.1 \
    ivonet/intellij
