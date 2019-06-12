#!/bin/bash

CONTAINER_NAME="cblackarch"

function is_container_running() {
    sudo docker ps | grep "${CONTAINER_NAME}" > /dev/null
}
function does_container_exist() {
    sudo docker ps -a | grep "${CONTAINER_NAME}" > /dev/null
}

if does_container_exist; then 
    if is_container_running; then
        echo "[!] Container already running"
        exit 1
    fi
    # container already exist but not started, just start and attach
    sudo docker start "${CONTAINER_NAME}" > /dev/null
    sudo docker attach "${CONTAINER_NAME}"
else
    # container never started before, run a new container
    sudo docker run \
        --hostname=arch \
        --name="${CONTAINER_NAME}"\
        -it \
        --net="host" \
        --privileged \
        -v "${HOME}":"${HOME}" \
        -u "${USER}" \
        blackarch:latest /usr/bin/zsh
fi
