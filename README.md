# Overwiev

This is forked from original https://github.com/liferay/liferay-docker repo, to allow for the building of docker images under arm64.

Couple of changes made:
 - uses openJDK 8 instead of zulu8
 - uses fonts-dejavu instead of ttf-dejavu
 - does not use set_java_version.sh
 - a couple of things missing from changed scripts - no ability to push and no test stage for local image
 - image name/tags are set 

This should not be used in any production environment without previously checking the differences between original repo and this.

# Usage

 - Download liferay bundle: https://www.liferay.com/downloads-community
 - Clone this repo
 - Run build_base_image.sh
 - Run build_local_image.sh <path_to_bundle> <image_name> <tag_name>
 - Docker run newly created image/use that image in compose/do whatever
