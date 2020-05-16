#!/usr/bin/env bash

export WORKDIR=$(cd $(dirname "$0") && pwd)

DOCKER_TEST_IMAGE=macunha1/ansible:alpine-3.11.5
CONTAINER_NAME="${WORKDIR##*/}-$(date +"%Y-%m-%d")"

DOCKER_CONTAINER=$(docker ps -a -f "name=${CONTAINER_NAME}" \
	-f "ancestor=${DOCKER_TEST_IMAGE}" \
	--format '{{ .Names }}' | head -n 1)

[ -z "${DOCKER_CONTAINER}" ] && {
	ROLE_DIR=/usr/local/opt

	RUNNER=$(docker run -it --name ${CONTAINER_NAME} \
		--rm \
		-v ${WORKDIR}:${ROLE_DIR} \
		-w ${ROLE_DIR} \
		--entrypoint "sh" \
		-d $DOCKER_TEST_IMAGE)
} || {
	RUNNER=${DOCKER_CONTAINER}
}

assert() {
	docker exec -it $RUNNER $1 ||
		(echo 'Test for command "'${1}'" just failed' && exit 1)
}

{
	assert "pip install ansible==2.9.6"
	assert "ansible-playbook -c local --syntax-check test.yaml" &&
		assert "ansible-playbook -c local test.yaml"

	# docker stop $RUNNER
} || {
	echo "Tests are failing"
	docker exec -it $RUNNER /bin/sh
}
