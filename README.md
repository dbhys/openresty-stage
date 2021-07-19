# Openresty Stage

## What's Openresty Stage

Openresty Stage is a docker image for building a openresty base stage. You can use openresty easily by lua, just copy or mount your lua project into /usr/local/stage (you can change it by docker arg PREFIX)

## More about this project

Base image is alpine:3.13, and the core files are copied from openresty:alpine, then we add some basic dependency libraries，such as libstdc++、libgcc、openssl

## Command

### Build

docker build -t openresty-stage:1.0.1 .

### Run

When you run this image directly or test your service on your host, we recommended that you use “--net=host” arg to run docker container. But it doesn't work on Mac.

#### Run a container

 docker run -d --net=host --rm openresty-stage:1.0.1

#### Run in container

 1. docker run -it --net=host --rm openresty-stage:1.0.1 sh
 2. /usr/local/openresty/bin/openresty -p ${PREFIX} -g 'daemon off;'


