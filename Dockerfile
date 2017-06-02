FROM node:6-alpine
MAINTAINER i6 Dev Team <dev-team@i6.io>

ENV HOME=/\
 CLOUDSDK_PYTHON_SITEPACKAGES=1\
 PATH=/google-cloud-sdk/bin:$PATH

RUN set -x\
 && echo "http://nl.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories\
 && apk update\
 && apk --no-cache add --virtual .build-deps\
  ca-certificates\
  unzip\
  wget\
&& apk --no-cache add\
  git\
  zip\
  bash\
  openssh-client\
  py2-openssl\
  python2\
 && wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip\
 && unzip google-cloud-sdk.zip\
 && rm google-cloud-sdk.zip\
 && google-cloud-sdk/install.sh\
  --usage-reporting=true\
  --path-update=true\
  --bash-completion=true\
  --rc-path=/.bashrc\
 && apk del .build-deps\
 && rm -rf /var/cache/apk/*\
 && google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true\
 && sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json\
 && mkdir /.ssh

