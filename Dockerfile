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

ARG AWS_CLI_VERSION
RUN apk update && apk add aws-cli==${AWS_CLI_VERSION}

WORKDIR /root/app/site-packages
COPY --from=builder /venv /venv
ENV PATH=/venv/bin:$PATH

COPY . .

USER root

VOLUME /app/data

ENTRYPOINT ["python3", "/root/app/site-packages/bin/awslocal"]

