#!/bin/bash

ROLE_DIR=/var/tests
CURRENT_DIR=$(dirname $0)
[[ "${CURRENT_DIR}" == '.' ]] && CURRENT_DIR=$(pwd)
IMAGE=macunha1/ansible:ubuntu-14.04
CONTAINER_NAME="${CURRENT_DIR##*/}-$(date +"%Y-%m-%d")"

_CONTAINER=$(docker ps -a -f "name=${CONTAINER_NAME}" \
        -f "ancestor=${IMAGE}" \
        --format '{{ .Names }}' | head -n 1)

[ -z "${_CONTAINER}" ] && {
    RUNNER=$(docker run -it --name $CONTAINER_NAME \
        -v $CURRENT_DIR:$ROLE_DIR \
        -w $ROLE_DIR \
        -d $IMAGE bash)
} || {
    RUNNER=${_CONTAINER}
}

assert () {
    docker exec -it $RUNNER $1 || \
        ( echo ${2-'Test is failed'} && exit 1 )
}

{
    assert "ansible-galaxy install -r requirements.yml" &&
    assert "ansible-playbook -c local --syntax-check test.yml" &&
    assert "ansible-playbook -c local test.yml"
} || {
    echo "Tests are failed"
    docker exec -it $RUNNER /bin/bash
}

docker rm $(docker stop $RUNNER)
