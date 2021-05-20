# NVIDIA Jetson Nano images

Powered by [Citymesh](https://citymesh.com/)

<pre>
   ___ _ _                             _     
  / __(_) |_ _   _ _ __ ___   ___  ___| |__  
 / /  | | __| | | | '_ ` _ \ / _ \/ __| '_ \ 
/ /___| | |_| |_| | | | | | |  __/\__ \ | | |
\____/|_|\__|\__, |_| |_| |_|\___||___/_| |_|
             |___/                           
</pre>


## What

This repository allows you to build an independent, containerized Deepstream solution for Jetson Nano. The resulting container contains all dependencies without the need of any libraries mounted from the host system.

Some trickery is involved to keep the resulting image size small, as Deepstream normally requires all examples and documentation to be present.


## How

The installation is chained using the build scripts. To skip a build step, remove the build step from the `BUILD_STEPS` array in the build script.

Some environment variables are needed.
* `BALENA_TAG` is provided to define the Balena image date tag.
* `GIT_HASH` is for traceability of current repo. If changes are made to a Dockerfile, please set the  environment variable to `test` or something. If the build is ok, commit the changes to git and build again the image with as tag the short git tag.
* `DOCKER_REG` is to define where the Docker image is pushed.
* `DOCKER_PUSH` is to define if the image needs to be pushed.


## Run

Provide a `environment.sh` file with following variables
```
BALENA_TAG='<BALENA_DOCKER_DATE_TAG>'
GIT_HASH=<HASH_FOR_CURRENT_REPO_TRACEABILITY>
DOCKER_REG='<LOCATION_TO_STORE_DOCKER_IMAGE>'
DOCKER_PUSH=<0_OR_1>
```
e.g.
```
BALENA_TAG='bionic-run-20200913'
GIT_HASH=$(git rev-parse --short=8 HEAD)
DOCKER_REG='registry.docker.com/jetson-nano'
DOCKER_PUSH=1
```

Run the build in the background for example using SSH on an aarch64 device without leaving the SSH session open.
```
./build[-run|-dev].sh >> build[-run|-dev].log &
disown
```
e.g.
```
./build-run.sh >> build-run.log &
disown
```
