#!/bin/bash

image_name="open-webui"
container_name="open-webui"
host_port=3000
container_port=8080

docker build -t "$image_name" .
docker stop "$container_name" &>/dev/null || true
docker rm "$container_name" &>/dev/null || true

docker run -d -p "$host_port":"$container_port" \
    -e OPENAI_API_KEY=$OPENAI_API_KEY \
    -v "${image_name}:/app/backend/data" \
    --name "$container_name" \
    --restart always \
    "$image_name"

docker image prune -f
