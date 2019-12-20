#!/bin/bash
sed -i "s#alpine:3.11#alpine:3.11#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.11 --compress --squash .
sed -i "s#alpine:3.11#alpine:3.10#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.10 --compress --squash .
sed -i "s#alpine:3.10#alpine:3.9#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.9 --compress --squash .
sed -i "s#alpine:3.9#alpine:3.8#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.8 --compress --squash .
sed -i "s#alpine:3.8#alpine:3.7#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.7 --compress --squash .
sed -i "s#alpine:3.7#alpine:3.6#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.6 --compress --squash .
sed -i "s#alpine:3.6#alpine:3.5#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.5 --compress --squash .
sed -i "s#alpine:3.5#alpine:edge#g" Dockerfile
docker build -t tiredofit/nginx:alpine-edge --compress --squash .
docker push tiredofit/nginx:alpine-3.11
docker push tiredofit/nginx:alpine-3.10
docker push tiredofit/nginx:alpine-3.9
docker push tiredofit/nginx:alpine-3.8
docker push tiredofit/nginx:alpine-3.7
docker push tiredofit/nginx:alpine-3.6
docker push tiredofit/nginx:alpine-3.5
docker push tiredofit/nginx:alpine-edge
sed -i "s#alpine:edge#alpine:3.11#g" Dockerfile
