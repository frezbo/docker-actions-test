FROM --platform=${BUILDPLATFORM:-linux/amd64} golang@sha256:124966f5d54a41317ee81ccfe5f849d4f0deef4ed3c5c32c20be855c51c15027 AS builder

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
