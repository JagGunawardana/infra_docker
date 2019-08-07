TERRAFORM_VERSION=0.12.6
TERRAFORM_CHECKSUM=6544eb55b3e916affeea0a46fe785329c36de1ba1bdb51ca5239d3567101876f
TERRAFORM_FILENAME=terraform_${TERRAFORM_VERSION}_linux_amd64.zip

all: terraform_${TERRAFORM_VERSION}_linux_amd64.zip

downloads:
	mkdir downloads

downloads/terraform_checksum: downloads
	echo "${TERRAFORM_CHECKSUM}  downloads/${TERRAFORM_FILENAME}" > downloads/terraform_checksum

${TERRAFORM_FILENAME}: downloads downloads/terraform_checksum
	curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILENAME} > downloads/${TERRAFORM_FILENAME}
	cat downloads/${TERRAFORM_FILENAME} | sha256sum -c downloads/terraform_checksum
	cp downloads/${TERRAFORM_FILENAME} .


.PHONY: clean

clean:
	rm -rf downloads
