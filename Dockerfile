FROM debian:latest
MAINTAINER it-operations@boerse-go.de
ENV NOMAD_VERSION=0.3.0

# Needed for ca-certificates :)
# See error: "x509: failed to load system roots and no roots provided"
RUN apt-get update &&\
    apt-get install -y curl ca-certificates unzip &&\
    curl -O https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip &&\
    unzip nomad_${NOMAD_VERSION}_linux_amd64.zip &&\
    apt-get clean &&\
    rm -r nomad_${NOMAD_VERSION}_linux_amd64.zip /var/lib/apt/lists/*

EXPOSE :4646
EXPOSE :4647
EXPOSE :4648

ENTRYPOINT ["/nomad"]
