GOLANG_VERSION=6.45
REV=1

REGISTRY=hub.ucloudadmin.com
THE_USER=devops
IMAGE_NAME=wekan
IMAGE_TAG=${GOLANG_VERSION}-${REV}-fgz
MANIFEST=${IMAGE_NAME}

# remove local manifest from previous build so that
# we don't have previous versions to pollute the new build
podman manifest exists ${MANIFEST}
if [[ $? -eq 0 ]]; then
    podman manifest rm ${MANIFEST}
fi

podman manifest create ${MANIFEST}
podman build \
    -f Dockerfile-alpine \
    --jobs 2 \
    --platform linux/amd64 \
    --manifest ${MANIFEST} \
    --tag $REGISTRY/$THE_USER/$IMAGE_NAME:$IMAGE_TAG \
    .

#podman manifest push --all ${MANIFEST} docker://$REGISTRY/$THE_USER/$IMAGE_NAME:$IMAGE_TAG
