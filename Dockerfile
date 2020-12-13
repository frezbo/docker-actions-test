FROM --platform=${BUILDPLATFORM:-linux/amd64} golang@sha256:28ef9a17b8cefebb3cf12d09fed9f2a6d5dae791ab2d83800e35a8b4662dffcf AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOPATH=/go/src/
WORKDIR /go/src/github.com/frezbo/docker-actions-test

COPY go.* .
RUN go mod download

COPY . .
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build

FROM scratch
COPY --from=builder /go/src/github.com/frezbo/docker-actions-test/docker-actions-test /bin/docker-actions-test
USER 1000
ENTRYPOINT ["/bin/docker-actions-test"]
