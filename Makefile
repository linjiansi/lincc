IMAGE_NAME = lincc
CONTAINER_NAME = lincc_container

docker_build:
	docker build -t $(IMAGE_NAME) .

docker_run: docker_build
	docker run --rm --name $(CONTAINER_NAME) $(IMAGE_NAME) make test

docker_clean:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)

lincc: main.c
	gcc -o lincc main.c

test: lincc
	./test.sh

.PHONY: test clean

