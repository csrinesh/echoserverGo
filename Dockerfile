# Build Stage
FROM lacion/alpine-golang-buildimage:1.13 AS build-stage

LABEL app="build-echoserverGo"
LABEL REPO="https://github.com/csrinesh/echoserverGo"

ENV PROJPATH=/go/src/github.com/csrinesh/echoserverGo

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/csrinesh/echoserverGo
WORKDIR /go/src/github.com/csrinesh/echoserverGo

RUN make build-alpine

# Final Stage
FROM lacion/alpine-base-image:latest

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/csrinesh/echoserverGo"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/echoserverGo/bin

WORKDIR /opt/echoserverGo/bin

COPY --from=build-stage /go/src/github.com/csrinesh/echoserverGo/bin/echoserverGo /opt/echoserverGo/bin/
RUN chmod +x /opt/echoserverGo/bin/echoserverGo

# Create appuser
RUN adduser -D -g '' echoserverGo
USER echoserverGo

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/echoserverGo/bin/echoserverGo"]
