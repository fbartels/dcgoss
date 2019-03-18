ARG DOCKER_VERSION=18.09.1
FROM docker:${DOCKER_VERSION}

ARG GOSS_VERSION
ARG DGOSS_VERSION
ARG COMPOSE_VERSION
ENV GOSS_VERSION=${GOSS_VERSION:-0.3.6}
ENV DGOSS_VERSION=${DGOSS_VERSION:-0.3.6}
ENV COMPOSE_VERSION=${DOMPOSE_VERSION:-1.23.2}

RUN apk add --no-cache bash py-pip dumb-init
RUN pip install --no-cache-dir docker-compose==${COMPOSE_VERSION}

ADD https://github.com/aelsabbahy/goss/releases/download/v${DGOSS_VERSION}/dgoss /usr/local/bin/
ADD https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64 /usr/local/bin/goss
RUN chmod 0755 /usr/local/bin/goss
RUN chmod 0755 /usr/local/bin/dgoss

COPY build/dcgoss /usr/local/bin/

VOLUME ["/repo"]

WORKDIR /repo

ENV GOSS_FILES_PATH tests

ENTRYPOINT ["dumb-init", "--"]

CMD ["dcgoss"]
