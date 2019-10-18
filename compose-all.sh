#!/bin/bash
if [[ ! -e docker-compose.override.yml ]]; then
    echo "version: '2.3'" > docker-compose.override.yml
fi
docker-compose -f docker-compose.yml -f docker-compose-with-media-server.yml -f docker-compose-with-gpu-obj-detection.yml -f docker-compose.override.yml "$@"
