FROM ivonet/ubuntu:22.04 AS builder


RUN /usr/bin/curl -s -L "https://download.jetbrains.com/idea/ideaIU-2023.3.3.tar.gz" | /bin/tar xz -C /opt/ \
 && mv -v /opt/idea* /opt/idea

#FROM ivonet/x11webui:2.2_22.04
FROM ivonet/web-vnc:1.1.0_22.04

COPY --from=builder /opt/idea /opt/idea

RUN apt-get update -qq -y \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openjdk-21-jdk \
    git \
    maven \
    python3 \
    nodejs \
    at-spi2-core \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && case $(arch) in \
      x86_64 | amd64) \
        ln -s /usr/lib/jvm/java-21-openjdk-amd64 /usr/lib/jvm/java-21-openjdk ;; \
      aarch64 | arm64) \
        ln -s /usr/lib/jvm/java-21-openjdk-arm64 /usr/lib/jvm/java-21-openjdk ;; \
      *) \
        echo "Unsupported architecture $(arch)" \
        ;; \
    esac \
 && chown -R abc:abc /config


COPY root/ /

ARG APP=intellij
ARG USR=user
ARG PWD=secret

ENV IDE_HOME=/opt/idea \
    IDE_BIN_HOME=/opt/idea/bin \
    VM_OPTIONS_FILE=/opt/idea/bin/idea.vmoptions \
    JAVA_HOME=/usr/lib/jvm/java-21-openjdk \
    PATH=.:/usr/lib/jvm/java-21-openjdk/bin:$PATH \
    APPNAME=$APP \
    USERNAME=$USR \
    PASSWORD=$PWD

WORKDIR /project
VOLUME /project
