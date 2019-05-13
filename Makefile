VERSION := $(shell cat version.txt)
APP := sre-build
CONTAINER := $(APP)-$(VERSION)-test

.phony: all build build-nc clean run test release

build:
	docker build -t $(APP):$(VERSION) --rm .

build-nc:
	docker build --no-cache -t $(APP):$(VERSION) --rm .

run: build
	docker run --rm -it $(APP):$(VERSION)

run-py: build
	docker run --rm -it $(APP):$(VERSION) python

clean:
	docker kill $(CONTAINER) || true
	docker rm $(CONTAINER) || true

test: clean build
	docker run -d --rm --name "$(CONTAINER)" -t $(APP):$(VERSION)
	sleep 5
	docker exec $(CONTAINER) goss -g /opt/tests/test_build_base.yml v --color
	docker kill $(CONTAINER)

release: build test
	docker tag $(APP):$(VERSION) $(REMOTE_TAG)
	docker push $(REMOTE_TAG)
	git tag -a $(VERSION) -m "Source for: $(REMOTE_TAG)" -f
	git push -f origin $(VERSION)
