IMAGE_NAME = jacoelho/ansible
TAG = latest
BUILD = $(shell bash -c 'echo $$RANDOM')

all: base

base:
	docker build --rm=true -t $(IMAGE_NAME) .
	docker run --cidfile build.cid --name $(BUILD) -d $(IMAGE_NAME) true
	docker export `cat build.cid` | docker import - $(IMAGE_NAME)
	docker tag -f $(IMAGE_NAME) $(IMAGE_NAME):$(TAG)

push:
	docker push $(IMAGE_NAME)
