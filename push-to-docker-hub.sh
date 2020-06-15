#!/bin/bash
docker rmi tiredofit/alpine:edge
docker rmi tiredofit/alpine:3.12
docker rmi tiredofit/alpine:3.11
docker rmi tiredofit/alpine:3.10
docker rmi tiredofit/alpine:3.9
docker rmi tiredofit/alpine:3.8
docker rmi tiredofit/alpine:3.7
docker rmi tiredofit/alpine:3.6
docker rmi tiredofit/alpine:3.5
docker rmi tiredofit/nginx:alpine-3.12
docker rmi tiredofit/nginx:alpine-3.11
docker rmi tiredofit/nginx:alpine-3.10
docker rmi tiredofit/nginx:alpine-3.9
docker rmi tiredofit/nginx:alpine-3.8
docker rmi tiredofit/nginx:alpine-3.7
docker rmi tiredofit/nginx:alpine-3.6
docker rmi tiredofit/nginx:alpine-3.5
docker rmi tiredofit/nginx:alpine-edge
docker build -t tiredofit/nginx:alpine-3.12 --compress --squash --no-cache .
sed -i "s#alpine:3.12#alpine:3.11#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.11 --compress --squash --no-cache .
sed -i "s#alpine:3.11#alpine:3.10#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.10 --compress --squash --no-cache .
sed -i "s#alpine:3.10#alpine:3.9#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.9 --compress --squash --no-cache .
sed -i "s#alpine:3.9#alpine:3.8#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.8 --compress --squash --no-cache .
sed -i "s#alpine:3.8#alpine:3.7#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.7 --compress --squash --no-cache .
sed -i "s#alpine:3.7#alpine:3.6#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.6 --compress --squash --no-cache .
sed -i "s#alpine:3.6#alpine:3.5#g" Dockerfile
docker build -t tiredofit/nginx:alpine-3.5 --compress --squash --no-cache .
sed -i "s#alpine:3.5#alpine:edge#g" Dockerfile
docker build -t tiredofit/nginx:alpine-edge --compress --squash --no-cache .
docker push tiredofit/nginx:alpine-3.12
docker push tiredofit/nginx:alpine-3.11
docker push tiredofit/nginx:alpine-3.10
docker push tiredofit/nginx:alpine-3.9
docker push tiredofit/nginx:alpine-3.8
docker push tiredofit/nginx:alpine-3.7
docker push tiredofit/nginx:alpine-3.6
docker push tiredofit/nginx:alpine-3.5
docker push tiredofit/nginx:alpine-edge
sed -i "s#alpine:edge#alpine:3.12#g" Dockerfile
