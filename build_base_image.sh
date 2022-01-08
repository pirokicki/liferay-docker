#!/bin/bash

source ./_common.sh

function build_docker_image {
	local image_version="liferay-trial-base"

	DOCKER_IMAGE_TAGS=()
	DOCKER_IMAGE_TAGS+=("prokicki/trial:${image_version}-${TIMESTAMP}")
	DOCKER_IMAGE_TAGS+=("prokicki/base")

	docker build \
		--build-arg LABEL_BUILD_DATE=$(date "${CURRENT_DATE}" "+%Y-%m-%dT%H:%M:%SZ") \
		--build-arg LABEL_NAME="Running environment for Liferay bundles - OS, JVM and tools" \
		--build-arg LABEL_VCS_REF=$(git rev-parse HEAD) \
		--build-arg LABEL_VCS_URL="https://github.com/liferay/liferay-docker" \
		--build-arg LABEL_VERSION="${image_version}" \
		$(get_docker_image_tags_args "${DOCKER_IMAGE_TAGS[@]}") \
		"${TEMP_DIR}" || exit 1
}

function main {
	make_temp_directory templates/base

	build_docker_image

	clean_up_temp_directory
}

main "${@}"
