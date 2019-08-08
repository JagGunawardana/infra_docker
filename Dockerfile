FROM google/cloud-sdk:256.0.0-alpine

ARG TERRAFORM_FILENAME
ENV TERRAFORM_FILENAME=$TERRAFORM_FILENAME
COPY ${TERRAFORM_FILENAME} /tmp/terraform.zip
RUN unzip /tmp/terraform.zip -d /bin && \
    gcloud components install kubectl
