ARG BUILDER_IMAGE
FROM ${BUILDER_IMAGE} AS builder

RUN apk add opentofu && ln -s /usr/bin/tofu /usr/bin/terraform

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["/venv/bin/tflocal"]

