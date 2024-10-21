#!/bin/bash

cd

git clone https://github.com/andradesysadmin/mymp3

cd mymp3/

sudo docker build -t mymp3 .

sudo docker run \
--restart always \
-d \
--name mymp3 \
-p 8080:80 \
mymp3