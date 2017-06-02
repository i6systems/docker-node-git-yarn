FROM node:6.9-slim
MAINTAINER i6 Dev Team <dev-team@i6.io>
RUN apt-get update && apt-get install -y apt-transport-https git \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn \
    && rm -rf /var/lib/apt/lists/*
