IMAGE = ippart/webhook
CONTAINER = ippart_webhook
PORT = -p 8901:80
DOCKER_RM = false

build:
	@docker build -t $(IMAGE) .

buildfs:
	@docker run --rm \
		-v $(CURDIR)/runner:/runner \
		-v $(CURDIR)/build:/build \
		-v $(CURDIR)/src:/src \
		imega/base-builder \
		--packages=" \
			nginx-common@v34 \
			nginx-lua@v34 \
			lua5.1-cjson \
			git \
			curl \
			make \
			docker@v32 \
			" \
		-d="lua5.1 luarocks@community"

start:
	@docker run -d --name $(CONTAINER) \
		-v /root/.dockercfg:/root/.dockercfg \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--restart=always \
		$(PORT) $(IMAGE)

test: build start
	@docker run --rm=$(DOCKER_RM) \
		-v $(CURDIR)/tests:/data \
		-w /data \
		--link $(CONTAINER):service \
		alpine \
		sh -c 'apk add --update bash curl jq && ./test.sh service'

stop:
	@-docker stop $(CONTAINER)

clean: stop
	@-docker rm -fv $(CONTAINER)

destroy:
	@-docker rmi $(IMAGE)

.PHONY: build
