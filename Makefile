GO_PROTOBUF_VERSION := 1.3.1

.PHONY: container
container:
	docker build --build-arg GO_PROTOBUF_VERSION=${GO_PROTOBUF_VERSION} --tag 110y/go-protoc:${GO_PROTOBUF_VERSION} .

.PHONY: registry
registry: container
	docker push 110y/go-protoc:${GO_PROTOBUF_VERSION}
