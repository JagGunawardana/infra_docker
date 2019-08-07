FROM google/cloud-sdk:256.0.0-alpine

ARG TERRAFORM_VERSION=0.12.6
ENV TERRAFORM_VERSION=$TERRAFORM_VERSION
COPY terraform_${TERRAFORM_VERSION}_linux_amd64.zip /tmp/terraform.zip
RUN unzip /tmp/terraform.zip -d /bin
