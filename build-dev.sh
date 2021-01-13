#!/usr/bin/env bash

source environment.sh

DEVICE='jetson-nano'

echo "Start building Docker images for ${DEVICE}"
date

# Build all sub containers
BUILD_STEPS=(cuda10-2-dev ds5 opencv4-dev)
DOCKER_ENTRIES=()
DOCKER_REG_ENTRY=$DOCKER_REG/$DEVICE

for BUILD_STEP in ${BUILD_STEPS[@]}; do
  DOCKER_REG_ENTRY=$DOCKER_REG_ENTRY-$BUILD_STEP
  docker build --build-arg prev_entry=$DOCKER_PREV_REG_ENTRY:$BALENA_TAG-$GIT_HASH --build-arg balena_tag=$BALENA_TAG \
    -t $DOCKER_REG_ENTRY:$BALENA_TAG-$GIT_HASH -f ./$BUILD_STEP/Dockerfile .
  
  if [ $? -eq 0 ]; then
    echo "Build build-step ${BUILD_STEP} successful"
    DOCKER_PREV_REG_ENTRY=$DOCKER_REG_ENTRY
    DOCKER_ENTRIES+=( $DOCKER_REG_ENTRY )
  else
    echo "Build failed at build step ${BUILD_STEP}" >&2
    exit 1
  fi
  date
done

echo "Build image ${DOCKER_REG_ENTRY}:${BALENA_TAG}-${GIT_HASH} successful"

# Push containers to registry
if [ $BALENA_PUSH -eq 1 ]; then
  for DOCKER_REG_ENTRY in ${DOCKER_ENTRIES[@]}; do
    docker push $DOCKER_REG_ENTRY:$BALENA_TAG-$GIT_HASH

    if [ $? -eq 0 ]; then
      echo "Push image ${DOCKER_REG_ENTRY}:${BALENA_TAG}-${GIT_HASH} successful"
    else
      echo "Push image ${DOCKER_REG_ENTRY}:${BALENA_TAG}-${GIT_HASH} failed"
      exit 1
    fi
  done
fi
date

