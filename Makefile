.PHONY: build build-alpine clean test help default

<<<<<<< HEAD
BIN_NAME=echoserverGo
=======
BIN_NAME=myProject
>>>>>>> 7e6a4817615ef45de64aafc571b2cdfafbe7061f

VERSION := $(shell grep "const Version " version/version.go | sed -E 's/.*"(.+)"$$/\1/')
GIT_COMMIT=$(shell git rev-parse HEAD)
GIT_DIRTY=$(shell test -n "`git status --porcelain`" && echo "+CHANGES" || true)
BUILD_DATE=$(shell date '+%Y-%m-%d-%H:%M:%S')
<<<<<<< HEAD
IMAGE_NAME := "lacion/echoserverGo"
=======
IMAGE_NAME := "lacion/myProject"
>>>>>>> 7e6a4817615ef45de64aafc571b2cdfafbe7061f

default: test

help:
<<<<<<< HEAD
	@echo 'Management commands for echoserverGo:'
=======
	@echo 'Management commands for myProject:'
>>>>>>> 7e6a4817615ef45de64aafc571b2cdfafbe7061f
	@echo
	@echo 'Usage:'
	@echo '    make build           Compile the project.'
	@echo '    make get-deps        runs dep ensure, mostly used for ci.'
<<<<<<< HEAD
	@echo '    make build-alpine    Compile optimized for alpine linux.'
	@echo '    make package         Build final docker image with just the go binary inside'
	@echo '    make tag             Tag image created by package with latest, git commit and version'
	@echo '    make test            Run tests on a compiled project.'
	@echo '    make push            Push tagged images to registry'
=======
	
>>>>>>> 7e6a4817615ef45de64aafc571b2cdfafbe7061f
	@echo '    make clean           Clean the directory tree.'
	@echo

build:
	@echo "building ${BIN_NAME} ${VERSION}"
	@echo "GOPATH=${GOPATH}"
<<<<<<< HEAD
	go build -ldflags "-X github.com/csrinesh/echoserverGo/version.GitCommit=${GIT_COMMIT}${GIT_DIRTY} -X github.com/csrinesh/echoserverGo/version.BuildDate=${BUILD_DATE}" -o bin/${BIN_NAME}
=======
	go build -ldflags "-X github.com/csrinesh/myProject/version.GitCommit=${GIT_COMMIT}${GIT_DIRTY} -X github.com/csrinesh/myProject/version.BuildDate=${BUILD_DATE}" -o bin/${BIN_NAME}
>>>>>>> 7e6a4817615ef45de64aafc571b2cdfafbe7061f

get-deps:
	dep ensure

<<<<<<< HEAD
build-alpine:
	@echo "building ${BIN_NAME} ${VERSION}"
	@echo "GOPATH=${GOPATH}"
	go build -ldflags '-w -linkmode external -extldflags "-static" -X github.com/csrinesh/echoserverGo/version.GitCommit=${GIT_COMMIT}${GIT_DIRTY} -X github.com/csrinesh/echoserverGo/version.BuildDate=${BUILD_DATE}' -o bin/${BIN_NAME}

package:
	@echo "building image ${BIN_NAME} ${VERSION} $(GIT_COMMIT)"
	docker build --build-arg VERSION=${VERSION} --build-arg GIT_COMMIT=$(GIT_COMMIT) -t $(IMAGE_NAME):local .

tag: 
	@echo "Tagging: latest ${VERSION} $(GIT_COMMIT)"
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):$(GIT_COMMIT)
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):${VERSION}
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):latest

push: tag
	@echo "Pushing docker image to registry: latest ${VERSION} $(GIT_COMMIT)"
	docker push $(IMAGE_NAME):$(GIT_COMMIT)
	docker push $(IMAGE_NAME):${VERSION}
	docker push $(IMAGE_NAME):latest

=======
>>>>>>> 7e6a4817615ef45de64aafc571b2cdfafbe7061f
clean:
	@test ! -e bin/${BIN_NAME} || rm bin/${BIN_NAME}

test:
	go test ./...

