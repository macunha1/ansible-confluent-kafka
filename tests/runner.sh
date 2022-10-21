#!/usr/bin/env bash

export WORKDIR=$(cd $(dirname "$0")/.. && pwd)

CONTAINER_TEST_IMAGE="${1:-'docker.io/macunha1/ansible:java-alpine-3.16.2'}"
CONTAINER_ENGINE="${2:-docker}"
CONTAINER_TEST_NAME="${WORKDIR##*/}-$(date +"%Y-%m-%d")"

ANSIBLE_ROLES_PATH=/usr/local/opt
ANSIBLE_ROLE_DIR=${ANSIBLE_ROLES_PATH}/macunha1.confluent_kafka

DOCKER_CONTAINER=$(${CONTAINER_ENGINE} container ls -a \
    -f "name=${CONTAINER_TEST_NAME}" \
    -f "ancestor=${CONTAINER_TEST_IMAGE}" \
    --format '{{ .Names }}' | head -n 1)

[[ -z "${DOCKER_CONTAINER}" ]] && {
    RUNNER=$(${CONTAINER_ENGINE} container run -it \
        --name ${CONTAINER_TEST_NAME} \
        -v ${WORKDIR}:${ANSIBLE_ROLE_DIR} \
        -e ANSIBLE_ROLES_PATH=${ANSIBLE_ROLES_PATH} \
        -w ${ANSIBLE_ROLE_DIR} \
        --entrypoint "sh" \
        -d ${CONTAINER_TEST_IMAGE})
} || {
    RUNNER=${DOCKER_CONTAINER}
}

assert() {
    ${CONTAINER_ENGINE} container exec -it ${RUNNER} $1 || {
        echo 'Test for command "'${1}'" just failed'
        exit 1
    }
}

{
    # Check code style and syntax
    assert "ansible-playbook -c local --syntax-check ${ANSIBLE_ROLE_DIR}/tests/playbook.yaml"

    # Run tests playbook
    assert "ansible-playbook -c local ${ANSIBLE_ROLE_DIR}/tests/playbook.yaml"
} || {
    echo "Tests are failing. To inspect container run:"
    echo "${CONTAINER_ENGINE} container exec -it ${RUNNER} sh"
    exit 1
} && {
    ${CONTAINER_ENGINE} container rm \
        $(${CONTAINER_ENGINE} container stop "${RUNNER}")
}
