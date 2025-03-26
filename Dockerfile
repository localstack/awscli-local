ARG BUILDER_IMAGE
ARG AWS_CLI_VERSION
FROM ${BUILDER_IMAGE} AS builder

WORKDIR /usr/src/app

RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

RUN pip install --upgrade pip
#RUN apk add cargo

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt 

FROM ${BUILDER_IMAGE} AS service

# Install the aws cli v2, which is now default in alpine
ARG AWS_CLI_VERSION
RUN apk update && apk add aws-cli==${AWS_CLI_VERSION} bash zip curl

#ENV PATH=/usr/bin:/venv/bin:/root/app/site-packages/bin:$PATH
ENV PATH=/usr/bin:/venv/bin:$PATH
WORKDIR /app/site-packages
COPY --from=builder /venv /venv

# Add awslocal to site-packages/bin, with priority to awsv2 bin
# As awscli is added for the bindings, v1 will be also added
COPY bin/awslocal-docker /venv/bin/awslocal

USER root

VOLUME /app/data
#SHELL ["/bin/bash"]
 
ENTRYPOINT ["/venv/bin/python3", "/root/app/site-packages/bin/awslocal"]

