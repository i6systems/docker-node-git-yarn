FROM alpine:latest as downloads
MAINTAINER i6 Dev Team <dev-team@i6.io>
ENV GCLOUD_BINARY=google-cloud-sdk-215.0.0-linux-x86_64.tar.gz
ENV GCLOUD_CHECKSUM=4cc8bf266848342a4f2b5b96381c7d7f4d8de79b6a1e9ae9ab855664eea65a52

RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${GCLOUD_BINARY} \
    && echo "${GCLOUD_CHECKSUM}  ${GCLOUD_BINARY}" | sha256sum -c -s \
    && tar zxf ${GCLOUD_BINARY} google-cloud-sdk \
    && rm ${GCLOUD_BINARY}

FROM node:6-slim as six
COPY --from=docker:18 /usr/local/bin/docker* /usr/bin/
COPY --from=downloads /google-cloud-sdk /google-cloud-sdk
RUN apt-get update && apt-get install -y lsb-release git \
    && /google-cloud-sdk/install.sh -q \
    && rm -rf /var/lib/apt/lists/*

FROM node:7-slim as seven
COPY --from=docker:18 /usr/local/bin/docker* /usr/bin/
COPY --from=downloads /google-cloud-sdk /google-cloud-sdk
RUN apt-get update && apt-get install -y lsb-release git \
    && /google-cloud-sdk/install.sh -q \
    && rm -rf /var/lib/apt/lists/*

FROM node:8-slim as eight
COPY --from=docker:18 /usr/local/bin/docker* /usr/bin/
COPY --from=downloads /google-cloud-sdk /google-cloud-sdk
RUN apt-get update && apt-get install -y lsb-release git \
    && /google-cloud-sdk/install.sh -q \
    && rm -rf /var/lib/apt/lists/*