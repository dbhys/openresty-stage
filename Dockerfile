ARG ENABLE_PROXY=false

FROM openresty/openresty:1.19.9.1-4-alpine AS production-stage


FROM alpine:3.13 AS last-stage

LABEL name="Openresty Stage" version="2.0.1" tags="openresty 1.19.9.1-4-alpine"

ARG ENABLE_PROXY
ARG PREFIX=/usr/local/stage

# add runtime, need libstdc++
RUN set -x \
     && (test "${ENABLE_PROXY}" != "true" || /bin/sed -i 's,https://dl-cdn.alpinelinux.org,https://mirrors.aliyun.com,g' /etc/apk/repositories) \
     && apk add --no-cache bash curl libstdc++ libgcc openssl pcre perl tzdata libcap zip zlib zlib-dev ca-certificates

COPY --from=production-stage /usr/local/openresty/ /usr/local/openresty/

ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

# You can replace the following configuration in your own Dockerfile, or more precisely, you may change PREFIX, COPY, EXPOSE
ENV PREFIX=$PREFIX
ENV SERVER_HOST=127.0.0.1
ENV SERVER_PORT=8080

WORKDIR $PREFIX

COPY ./conf/ ./conf/

RUN mkdir -p logs
    
EXPOSE 80

CMD /usr/local/openresty/bin/openresty -p ${PREFIX} -g 'daemon off;'

STOPSIGNAL SIGQUIT
