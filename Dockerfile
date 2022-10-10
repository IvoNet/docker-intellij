FROM ivonet/ubuntu:22.04 AS builder


RUN /usr/bin/curl -s -L "https://download.jetbrains.com/idea/ideaIU-2021.1.3.tar.gz" | /bin/tar xz -C /opt/ \
 && mv -v /opt/idea* /opt/idea

#FROM ivonet/x11webui:2.2_22.04
FROM ivonet/web-vnc:1.0.1_22.04

COPY --from=builder /opt/idea /opt/idea

RUN apt-get update -qq -y \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openjdk-8-jdk \
    openjdk-17-jdk \
    openjdk-11-jdk \
    git \
    maven \
    python3 \
    nodejs \
    at-spi2-core \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY root/ /

ARG APP=intellij
ARG USR=user
ARG PWD=secret

ENV IDE_HOME=/opt/idea \
    IDE_BIN_HOME=/opt/idea/bin \
    VM_OPTIONS_FILE=/opt/idea/bin/idea.vmoptions \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64 \
    PATH=/usr/lib/jvm/java-11-openjdk-arm64/bin:$PATH \
    APPNAME=$APP \
    USERNAME=$USR \
    PASSWORD=$PWD

WORKDIR /project
VOLUME /project
