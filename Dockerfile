FROM alpine:3.9.5

LABEL build.maintainer="Daniel Ascencio <daniel.ascencio.hz@gmail.com>"
LABEL build.date="24012020"
LABEL build.version="0.3.5"

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin
ENV CRONSUN_VERSION 0.3.5

RUN set -x \
    && echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && apk --no-cache add curl go git bash binutils-gold libc-dev \
    && mkdir -p /gopath/bin \
    && curl -L https://github.com/shunfei/cronsun/releases/download/v$CRONSUN_VERSION/cronsun-v$CRONSUN_VERSION-linux-amd64.zip -o cronsun.zip \
    && mkdir -p /opt \
    && unzip cronsun.zip -d /opt \
    && mv /opt/cronsun-v$CRONSUN_VERSION /opt/cronsun \
    && chmod +x /opt/cronsun/cronweb

EXPOSE 7079

WORKDIR /opt/cronsun

ENTRYPOINT []

CMD ./cronweb -conf conf/base.json