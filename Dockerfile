FROM golang:1.12.6-stretch

ENV GO111MODULE on

RUN apt-get update && apt-get install -y --no-install-recommends \
            autoconf=2.69-10 \
            automake=1:1.15-6 \
            libtool=2.4.6-2 \
            && rm -rf /var/lib/apt/lists/*

ENV PROTOBUF_VERSION 3.7.1

RUN wget -O /usr/local/src/protobuf.tar.gz "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-cpp-${PROTOBUF_VERSION}.tar.gz"
WORKDIR /usr/local/src
RUN tar xzf protobuf.tar.gz
WORKDIR /usr/local/src/protobuf-${PROTOBUF_VERSION}
RUN ./autogen.sh && ./configure && make && make install && ldconfig
RUN rm -rf /usr/local/src/protobuf*

ARG GO_PROTOBUF_VERSION

RUN git clone https://github.com/golang/protobuf /go/src/github.com/golang/protobuf
WORKDIR /go/src/github.com/golang/protobuf
RUN git checkout "v${GO_PROTOBUF_VERSION}"
RUN go build -o /go/bin/protoc-gen-go github.com/golang/protobuf/protoc-gen-go
RUN rm -rf /go/src/github.com/golang/protobuf

WORKDIR /go
