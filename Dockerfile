FROM --platform=${BUILDPLATFORM:-linux/amd64} golang@sha256:dac1fd50dc298852005ed2d84baa4f15ca86b1042fce6d8da3f98d6074294bf4 AS builder

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
