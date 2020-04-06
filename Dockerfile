FROM registry:2

RUN set -ex \
    && apk add --no-cache inotify-tools

COPY ./entrypoint.sh /entrypoint.sh
