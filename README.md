# Openresty Stage

## What's Openresty Stage

Openresty Stage is a docker image for building a openresty base stage. You can use openresty easily by lua, just copy or mount your lua project into /usr/local/stage (you can change it by docker arg PREFIX)

## More about this project

Base image is alpine:3.13, and the core files are copied from openresty:alpine, then we add some basic dependency libraries，such as libstdc++、libgcc、openssl


