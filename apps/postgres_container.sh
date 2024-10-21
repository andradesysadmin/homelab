#!/bin/bash

docker run --name postgres \
-e POSTGRES_USER=postres \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=postgres \
-p 5432:5432 \
-v pgdata:/var/lib/postgresql/data \
--restart always \
-d postgres:latest