#!/bin/bash

source ./_common.sh

function build_docker_image {
	local docker_image_name=${2}
    local version=${3}

	DOCKER_IMAGE_TAGS=()

	DOCKER_IMAGE_TAGS+=("${docker_image_name}:${version}-${TIMESTAMP}")
	DOCKER_IMAGE_TAGS+=("${docker_image_name}:${version}")

	docker build \
		--build-arg LABEL_BUILD_DATE=$(date "${CURRENT_DATE}" "+%Y-%m-%dT%H:%M:%SZ") \
		--build-arg LABEL_NAME="${docker_image_name}-${version}" \
		--build-arg LABEL_VCS_REF=$(git rev-parse HEAD) \
		--build-arg LABEL_VCS_URL="https://github.com/pirokicki/liferay-docker" \
		--build-arg LABEL_VERSION="${version}" \
		$(get_docker_image_tags_args "${DOCKER_IMAGE_TAGS[@]}") \
		"${TEMP_DIR}"
}

function check_usage {
	if [ ! -n "${3}" ]
	then
		echo "Usage: ${0} path-to-bundle image-name version <push>"
		echo ""
		echo "Example: ${0} ../bundles/master portal-snapshot demo-cbe09fb0 <push>"

		exit 1
	fi

	check_utils curl docker java
}

function main {
	check_usage "${@}"

	make_temp_directory templates/bundle

	prepare_temp_directory "${@}"

	prepare_tomcat

	build_docker_image "${@}"

	clean_up_temp_directory
}

function prepare_temp_directory {
	cp -a "${1}" "${TEMP_DIR}/liferay"
}

main "${@}"
