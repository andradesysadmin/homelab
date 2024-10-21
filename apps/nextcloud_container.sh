#!/bin/bash

docker run -d \
  --name nextcloud \
  -p 8088:80 \
  -v nextcloud_data:/var/www/html \
  --link postgres:db \
  --restart always \
  nextcloud