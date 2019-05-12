FROM ivonet/ubuntu:18.04 AS builder

#https://download-cf.jetbrains.com/idea/ideaIU-2019.1.2.tar.gz
#https://download-cf.jetbrains.com/idea/ideaIU-2019.1.2-jbr11.tar.gz
#https://download-cf.jetbrains.com/idea/ideaIU-2019.1.2-no-jbr.tar.gz
RUN /usr/bin/curl -s -L "https://download-cf.jetbrains.com/idea/ideaIU-2019.1.2-no-jbr.tar.gz" | /bin/tar xz -C /opt/ \
 && mv -v /opt/idea* /opt/idea
# && rm -rf /opt/idea/jre64

FROM ivonet/x11webui:latest

COPY --from=builder /opt/idea /opt/idea

#Fix:
#       Warning **: Error retrieving accessibility bus address:
#https://www.raspberrypi.org/forums/viewtopic.php?t=196070

RUN apt-get update -qq -y \
 && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        git \
        maven \
        at-spi2-core \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
# && ln -s /usr/lib/jvm/java-11-openjdk-amd64 /opt/idea/jre64

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
