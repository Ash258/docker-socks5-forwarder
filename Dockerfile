FROM alpine:3.23.2

ENV PROXY_PORT=1080 \
    REDSOCKS_PORT='12345' \
    UPSTREAM_HOST='' \
    UPSTREAM_PORT='' \
    UPSTREAM_USER='' \
    UPSTREAM_PASS=''

# hadolint ignore=DL3018
RUN --mount=type=cache,target=/var/cache/apk,sharing=locked \
    apk add \
    curl \
    ca-certificates \
    dante-server \
    gettext-envsubst \
    iptables \
    redsocks && \
    update-ca-certificates

COPY *.template /etc/
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE ${PROXY_PORT}

CMD [ "/entrypoint.sh" ]
