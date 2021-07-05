ARG ENABLE_PROXY=false

FROM openresty/openresty:alpine AS production-stage



FROM alpine:3.13 AS last-stage

LABEL name="Openresty Stage" version="0.0.1"

ARG ENABLE_PROXY
ARG PREFIX=/usr/local/stage
# add runtime, need libstdc++
RUN set -x \
     && (test "${ENABLE_PROXY}" != "true" || /bin/sed -i 's,https://dl-cdn.alpinelinux.org,https://mirrors.aliyun.com,g' /etc/apk/repositories) \
     && apk add --no-cache bash libstdc++ libgcc openssl pcre perl tzdata libcap zip zlib zlib-dev ca-certificates

WORKDIR $PREFIX

COPY --from=production-stage /usr/local/openresty/ /usr/local/openresty/

ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

RUN mkdir -p logs \
    && ln -sf /dev/stdout $PREFIX/logs/access.log \
    && ln -sf /dev/stderr $PREFIX/logs/error.log
    
EXPOSE 80

CMD ["sh", "-c", "/usr/local/openresty/bin/openresty -p", $PREFIX, "-g 'daemon off;'"]

STOPSIGNAL SIGQUIT
