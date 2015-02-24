IMAGE_NAME = jacoelho
TAG = 0.1
BUILD_CMD = docker build --no-cache --rm=true -t
TARGETS = ruby19-full ruby19 ruby21

.PHONY: $(TARGETS) compact clean test push tag_latest

all: $(TARGETS)

ruby19-full:
	cp  $@.yml answer.yml
	$(BUILD_CMD) $(IMAGE_NAME)/$@:$(TAG) .

ruby19:
	cp  $@.yml answer.yml
	$(BUILD_CMD) $(IMAGE_NAME)/$@:$(TAG) .

ruby21:
	cp  $@.yml answer.yml
	$(BUILD_CMD) $(IMAGE_NAME)/$@:$(TAG) .

tag_latest:
	@for image in $(TARGETS); do\
		docker tag -f $(IMAGE_NAME)/$$image:$(TAG) $(IMAGE_NAME)/$$image:latest; \
	done

compact:
	@for image in $(TARGETS); do\
		docker export `docker run -d $(IMAGE_NAME)/$$image:$(TAG) true` > image.tar; \
		docker import - $(IMAGE_NAME)/$$image:$(TAG) < image.tar; \
		rm -f image.tar; \
	done

push: tag_latest
	@for image in $(TARGETS); do\
		docker push $(IMAGE_NAME)/$$image:$(TAG) ;\
		docker push $(IMAGE_NAME)/$$image:latest ;\
	done

clean:
	rm -fr answer.yml

test:
	docker run --rm -t -i $(IMAGE_NAME)/$(IMAGE):$(TAG) /sbin/my_init -- bash -l
