#!/bin/bash
docker stop $(docker container ps --latest --quiet) \
&& docker build -t php-fpm-alpine:latest .