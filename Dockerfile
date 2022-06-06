FROM ivonet/ubuntu:20.04 AS builder


RUN /usr/bin/curl -s -L "https://download.jetbrains.com/idea/ideaIU-2022.1.2.tar.gz" | /bin/tar xz -C /opt/ \
 && mv -v /opt/idea* /opt/idea

#FROM ivonet/x11webui:2.2_22.04
FROM ivonet/web-vnc:1.0_22.04

COPY --from=builder /opt/idea /opt/idea

RUN apt-get update -qq -y \
 && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        openjdk-11-jdk \
        openjdk-17-jdk \
        git \
        maven \
        at-spi2-core \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY root/ /

ARG APP=intellij
ARG USR=user
ARG PWD=secret

ENV IDE_HOME=/opt/idea                                  \
    IDE_BIN_HOME=/opt/idea/bin                          \
    VM_OPTIONS_FILE=/opt/idea/bin/idea.vmoptions        \
    APPNAME=$APP                                        \
    USERNAME=$USR                                       \
    PASSWORD=$PWD

WORKDIR /project
VOLUME /project
