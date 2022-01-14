# Openresty Stage

## What's Openresty Stage

Openresty Stage is a docker image for building a openresty base stage. You can use openresty easily by lua, just copy or mount your lua project into /usr/local/stage (you can change it by docker arg PREFIX)

## More about this project

Base image is alpine:3.13, and the core files are copied from openresty:alpine, then we add some basic dependency libraries，such as libstdc++、libgcc、openssl

## Command

### Build

docker build -t openresty-stage:2.0.1 .

### Run

When you run this image directly or test your service on your host, we recommended that you use “--net=host” arg to run docker container. But it doesn't work on Mac.

#### Run a container

 docker run -d --net=host --rm openresty-stage:2.0.1

#### Run in container

 1. docker run -it --net=host --rm openresty-stage:2.0.1 sh
 2. /usr/local/openresty/bin/openresty -p ${PREFIX} -g 'daemon off;'

### How to use

Notice: you must add $PREFIX dir to the lua_package_path in your conf/nginx.conf. the example is in the [conf/nginx.conf](conf/nginx.conf). actually, the $prefix is the dir behind "openresty -p", in our image it is the same as $PREFIX.

#### Mount workdir

If you don't want to change anything of the container, just run your lua code, the best way is mount your workdir
to the container workdir(/usr/local/stage), and the dir must contain the file conf/nginx.conf

#### From this image

You can build your own image from this image, May be just replace those enviroment variables or commands (PREFIX, COPY, EXPOSE...)
