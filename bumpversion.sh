#!/bin/bash
set -e

VERSION_BUMP_TYPE=$1

echo "Bumping version..."
bump2version ${VERSION_BUMP_TYPE}


echo "Starting tagging process..."

DOCKER_REGISTRY="registry.insight-centre.org/sit/mps/felipe-phd"

SERVICE_PROJECT_LIST="object-detection-service adaptation-knowledge adaptation-monitor adaptation-analyser adaptation-planner scheduler client-manager window-manager event-dispatcher preprocessing-service matcher forwarder color-detection-service"

NEW_VERSION=v`cat VERSION`


echo 'Tagging containers and git repositories...'
echo 'Ensure latest version of all images are available...'
for SERVICE_NAME in $SERVICE_PROJECT_LIST; do
    IMAGE=${DOCKER_REGISTRY}${SERVICE_NAME}
    LATEST_IMAGE=${IMAGE}:latest
    echo 'Re-pulling latest image'
    docker pull ${LATEST_IMAGE}
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