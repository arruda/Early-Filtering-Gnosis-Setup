#!/bin/bash
set -e

VERSION_BUMP_TYPE=$1

echo "Bumping version..."
# bump2version ${VERSION_BUMP_TYPE}


echo "Starting tagging process..."

DOCKER_REGISTRY="registry.insight-centre.org/sit/mps/"

SERVICE_PROJECT_LIST="client-manager window-manager query-manager content-extraction-service publisher namespace-mapper query-planner event-dispatcher preprocessing-service matcher forwarder color-detection-service"

NEW_VERSION=v`cat VERSION`


echo 'Tagging containers and git repositories...'
echo 'Ensure latest version of all images are available...'
IMAGE_TAG=latest docker-compose pull
for SERVICE_NAME in $SERVICE_PROJECT_LIST; do
    IMAGE=${DOCKER_REGISTRY}${SERVICE_NAME}
    LATEST_IMAGE=${IMAGE}:latest
    NEW_TAG=${IMAGE}':'${NEW_VERSION}

    echo "Tagging Docker image: " $LATEST_IMAGE " > " $NEW_TAG
    docker tag $LATEST_IMAGE $NEW_TAG
    echo "pushing new Docker Image Tag to repository"
    docker push $NEW_TAG

    echo "Creating GIT tag in gitlab for ${SERVICE_NAME}"
    python tag_repositories.py ${SIT_TOKEN} ${SERVICE_NAME} ${NEW_VERSION}

    echo " "
done

git push origin refs/tags/${NEW_VERSION}