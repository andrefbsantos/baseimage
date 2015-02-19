IMAGE_NAME = jacoelho/base
TAG = latest
BUILD = $(shell bash -c 'echo $$RANDOM')

all: base

base:
	docker build --no-cache --rm=true -t $(IMAGE_NAME) .

compact:
	docker export `docker run -d $(IMAGE_NAME):$(TAG) true` > image.tar
	docker import - $(IMAGE_NAME):$(TAG) < image.tar
	rm -f image.tar

test:
	docker run --rm -t -i $(IMAGE_NAME):$(TAG) /sbin/my_init -- bash -l
