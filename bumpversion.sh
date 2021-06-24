#!/bin/bash
set -e

VERSION_BUMP_TYPE=$1

echo "Bumping version..."
bump2version ${VERSION_BUMP_TYPE}


echo "Starting tagging process..."

DOCKER_REGISTRY="registry.insight-centre.org/sit/mps/felipe-phd"

SERVICE_PROJECT_LIST="window-manager service-registry adaptation-knowledge event-dispatcher matcher scheduler object-detection-service object-detection-service-gpu adaptation-planner preprocessing-service adaptation-analyser adaptation-monitor client-manager forwarder"

NEW_VERSION=v`cat VERSION`


echo 'Tagging containers and git repositories...'
echo 'Ensure latest version of all images are available...'
for SERVICE_NAME in $SERVICE_PROJECT_LIST; do
    IMAGE=${DOCKER_REGISTRY}${SERVICE_NAME}
    if [[ $SERVICE_NAME == "object-detection-service-gpu" ]]
    then
        SERVICE_NAME="object-detection-service"
        IMAGE_AND_TAG=${IMAGE}:master-gpu
    else
        IMAGE_AND_TAG=${IMAGE}:master
    fi

    echo 'Re-pulling latest image: ${LATEST_IMAGE}'
    docker pull ${LATEST_IMAGE}
    NEW_TAG=${IMAGE}':'${NEW_VERSION}

    echo "Tagging Docker image: " $LATEST_IMAGE " > " $NEW_TAG
    # docker tag $LATEST_IMAGE $NEW_TAG
    echo "pushing new Docker Image Tag to repository"
    # docker push $NEW_TAG

    echo "Creating GIT tag in gitlab for ${SERVICE_NAME} ${NEW_VERSION}"
    # python tag_repositories.py ${SIT_TOKEN} ${SERVICE_NAME} ${NEW_VERSION}

    echo " "
done

git push origin refs/tags/${NEW_VERSION}