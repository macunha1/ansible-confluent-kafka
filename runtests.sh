#!/bin/sh

APPDIR=/var/tests
CURRENT_DIR=$(dirname $0)
[[ "${CURRENT_DIR}" == '.' ]] && CURRENT_DIR=$(pwd)
IMAGE=williamyeh/ansible:ubuntu16.04

RUNNER=$(docker run -v $CURRENT_DIR:$APPDIR \
    -w $APPDIR -t -i \
    -d $IMAGE bash)

assert () {
    docker exec -it $RUNNER $1 || \
        ( echo ${2-'Test is failed'} && exit 1 )
}

{
    assert "ansible-playbook -c local --syntax-check test.yml"          &&
    assert "ansible-playbook -c local test.yml"
} || {
    echo "Tests are failed"
    docker exec -it $RUNNER /bin/bash
}

docker rm $(docker stop $RUNNER)
