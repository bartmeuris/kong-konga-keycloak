ARG KONG_VERSION=2.4.1
FROM kong:${KONG_VERSION}-alpine

LABEL description="Alpine + Kong 2.0.4 + kong-oidc plugin"

ENV KONG_DATABASE=off \
    KONG_DECLARATIVE_CONFIG=/etc/kong.yaml \
    KONG_MEM_CACHE_SIZE=128m \
    KONG_NGINX_DAEMON=off \
    KONG_ANONYMOUS_REPORTS=off \
    KONG_PROXY_LISTEN=0.0.0.0:8000 \
    KONG_ADMIN_LISTEN=0.0.0.0:8001 \
    KONG_LOG_LEVEL=notice \
    KONG_PROXY_ACCESS_LOG=/dev/stdout \
    KONG_ADMIN_ACCESS_LOG=/dev/stdout \
    KONG_PROXY_ERROR_LOG=/dev/stderr \
    KONG_ADMIN_ERROR_LOG=/dev/stderr \
    KONG_SERVER_TOKENS=off \
    KONG_LATENCY_TOKENS=off \
    KONG_TRUSTED_IPS=0.0.0.0/0,::/0 \
    KONG_REAL_IP_HEADER=X-Forwarded-For \
    KONG_REAL_IP_RECURSIVE=on \
    KONG_PLUGINS=bundled,oidc \
    KONG_DNS_HOSTSFILE=/etc/hosts \
    KONG_CUSTOM_PLUGINS=


USER root
RUN apk --no-cache add git unzip luarocks &&\
    luarocks install --pin lua-resty-jwt 0.2.2-0 &&\
    luarocks install kong-oidc

USER kong
