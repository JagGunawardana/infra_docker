ifndef REGISTRY
$(error "REGISTRY variable not set")
endif

TERRAFORM_VERSION=0.12.6
TERRAFORM_CHECKSUM=6544eb55b3e916affeea0a46fe785329c36de1ba1bdb51ca5239d3567101876f
TERRAFORM_FILENAME=terraform_${TERRAFORM_VERSION}_linux_amd64.zip
DOCKER=infra_docker

all: ${TERRAFORM_FILENAME} .docker_build .docker_push

downloads:
	mkdir downloads

downloads/terraform_checksum: downloads
	echo "${TERRAFORM_CHECKSUM}  downloads/${TERRAFORM_FILENAME}" > downloads/terraform_checksum

${TERRAFORM_FILENAME}: downloads downloads/terraform_checksum
	curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILENAME} > downloads/${TERRAFORM_FILENAME}
	cat downloads/${TERRAFORM_FILENAME} | sha256sum -c downloads/terraform_checksum
	cp downloads/${TERRAFORM_FILENAME} ${TERRAFORM_FILENAME}

.docker_build: ${TERRAFORM_FILENAME}
	docker build -t ${REGISTRY}/${DOCKER}:latest --build-arg TERRAFORM_FILENAME=${TERRAFORM_FILENAME} .
	touch .docker_build

.docker_push: .docker_build
	docker push ${REGISTRY}/${DOCKER}:latest
	touch .docker_build

.PHONY: clean

clean:
	rm -rf downloads
	rm -f ${TERRAFORM_FILENAME}
	rm -f .docker_build
	rm -f .docker_push
