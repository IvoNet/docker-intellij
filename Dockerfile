FROM ivonet/ubuntu:18.04 AS builder

RUN /usr/bin/curl -s -L "https://download-cf.jetbrains.com/idea/ideaIU-2019.1.1.tar.gz" | /bin/tar xz -C /opt/ \
 && mv -v /opt/idea* /opt/idea \
 && rm -rf /opt/idea/jre64

FROM ivonet/web-gui-base:latest

COPY --from=builder /opt/idea /opt/idea

RUN apt-get update -qq -y \
 && apt-get install -y --no-install-recommends \
        openjdk-8-jdk \
        git \
        maven \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /usr/lib/jvm/java-8-openjdk-i386/jre /opt/idea/jre64

COPY root/ /

ARG APP=intellij
ARG USERNAME=user
ARG PASSWORD=secret
ARG ADMIN_NAME=ideadmin
ARG ADMIN_PASSWORD=ideadmin

ENV IDE_HOME=/opt/idea                           \
    IDE_BIN_HOME=/opt/idea/bin                   \
    VM_OPTIONS_FILE=/opt/idea/bin/idea.vmoptions \
    APPNAME=$APP                                 \
    GUACAMOLE_ADMIN_USERNAME=$ADMIN_NAME         \
    GUACAMOLE_ADMIN_PASSWORD=$ADMIN_PASSWORD     \
    GUACAMOLE_USER_NAME=$USERNAME                \
    GUACAMOLE_USER_PASSWORD=$PASSWORD

WORKDIR /project
VOLUME /project
