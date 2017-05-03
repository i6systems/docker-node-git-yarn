FROM node:6.9-alpine
MAINTAINER i6 Dev Team <dev-team@i6.io>
RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories && \
    apk add --no-cache \
        git \
        openssh \
        yarn