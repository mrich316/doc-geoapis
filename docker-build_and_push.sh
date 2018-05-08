#!/usr/bin/env bash
#
# Build and Push to a docker registry.
#

set -euo pipefail

PROJECT_NAME=territory_geocoding
BUILD_ARTIFACTS=${BUILD_ARTIFACTS:-`dirname "$0"`}

#DOCKER_USER=${DOCKER_USER:-admin}
#DOCKER_PASS=${DOCKER_PASS:-admin}
DOCKER_REGISTRY=${DOCKER_REGISTRY:-docker-registry-dev.laval.ca}

VERSION=$(git describe)
VERSION_MAJOR=$(echo $VERSION | awk -F . '{ print $1 }')
VERSION_MAJOR_MINOR=$(echo $VERSION | awk -F . '{ print $1"."$2 }')

echo ">>> Building app version $VERSION"
docker build \
  --pull \
  --tag $DOCKER_REGISTRY/$PROJECT_NAME:$VERSION \
  --tag $DOCKER_REGISTRY/$PROJECT_NAME:$VERSION_MAJOR_MINOR \
  --tag $DOCKER_REGISTRY/$PROJECT_NAME:$VERSION_MAJOR \
  --build-arg VERSION=$VERSION \
  $BUILD_ARTIFACTS

if [ -n "${DOCKER_USER+set}" ]; then
  echo ">>> Login to docker registry: $DOCKER_REGISTRY"
	echo $DOCKER_PASS | docker login --username="$DOCKER_USER" --password-stdin $DOCKER_REGISTRY;
fi

for tag in $VERSION $VERSION_MAJOR_MINOR $VERSION_MAJOR
do
   echo ">>> Pushing image: $PROJECT_NAME:$tag"
   docker push $DOCKER_REGISTRY/$PROJECT_NAME:$tag
done
