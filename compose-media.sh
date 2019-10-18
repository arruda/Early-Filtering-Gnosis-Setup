#!/bin/bash

docker-compose -f docker-compose.yml -f docker-compose-with-media-server.yml -f docker-compose.override.yml "$@"
