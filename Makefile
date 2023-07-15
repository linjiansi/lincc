IMAGE_NAME = lincc
CONTAINER_NAME = lincc_container
ARG =

docker_build:
	docker build -t $(IMAGE_NAME) .

test_on_docker: docker_build
	docker run --rm --name $(CONTAINER_NAME) $(IMAGE_NAME) make test

lincc_on_docker: docker_build
	docker run --rm --name $(CONTAINER_NAME) $(IMAGE_NAME) make exec_lincc ARG="$(ARG)"

docker_clean:
	docker run --rm --name $(CONTAINER_NAME) $(IMAGE_NAME) make clean

remove_container_and_image:
	docker rm -f $(CONTAINER_NAME)
	docker rmi -f $(IMAGE_NAME)

lincc: main.c
	gcc -o lincc main.c

exec_lincc: lincc
	./lincc $(ARG) > tmp.s
	cc -o tmp tmp.s
	./tmp
	echo $$?

test: lincc
	./test.sh

clean:
	rm -f lincc tmp tmp.s

.PHONY: docker_build, test_on_docker, lincc_on_docker, docker_clean, remove_container_and_image, lincc, exec_lincc, test, clean
