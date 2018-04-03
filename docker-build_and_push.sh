#!/bin/sh

set -ex

VERSION=$(git describe)
VERSION_MAJOR_MINOR=$(echo $VERSION | awk -F . '{ print $1"."$2 }')

DOCKER_HOST=testgeo1.laval.ca

#docker login --username=$DOCKER_USER --password=$DOCKER_PASS $DOCKER_HOST
docker build \
  --tag $DOCKER_HOST/doc_geoapis:$VERSION \
  --tag $DOCKER_HOST/doc_geoapis:$VERSION_MAJOR_MINOR \
  .

docker push $DOCKER_HOST/doc_geoapis:$VERSION
docker push $DOCKER_HOST/doc_geoapis:$VERSION_MAJOR_MINOR
