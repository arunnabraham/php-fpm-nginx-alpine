#!/bin/bash
docker build -t php-fpm-alpine:latest . \
&& docker restart $(docker container ps --latest --quiet)