FROM python:3.13.2-alpine3.21 AS builder

WORKDIR /usr/src/app

RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

RUN pip install --upgrade pip
#RUN apk add cargo

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt 

FROM python:3.13.2-alpine3.21 AS service
WORKDIR /root/app/site-packages
COPY --from=builder /venv /venv
ENV PATH=/venv/bin:$PATH

COPY . .

USER root

VOLUME /app/data

ENTRYPOINT ["/root/app/site-packages/bin/awslocal"]

