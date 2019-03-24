FROM golang:alpine as builder
MAINTAINER Jessica Frazelle <jess@linux.com>

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN	apk add --no-cache \
	bash \
	ca-certificates

COPY . /go/src/github.com/docker/asset-mongo-mexpress-stack

RUN set -x \
	&& apk add --no-cache --virtual .build-deps \
		git \
		gcc \
		libc-dev \
		libgcc \
		make \
	&& cd /go/src/github.com/docker/asset-mongo-mexpress-stack \
	&& make static \
	&& mv asset-mongo-mexpress-stack /usr/bin/asset-mongo-mexpress-stack \
	&& apk del .build-deps \
	&& rm -rf /go \
	&& echo "Build complete."

FROM alpine:latest

COPY --from=builder /usr/bin/asset-mongo-mexpress-stack /usr/bin/asset-mongo-mexpress-stack
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs

ENTRYPOINT [ "asset-mongo-mexpress-stack" ]
CMD [ "--help" ]
