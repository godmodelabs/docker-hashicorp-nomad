FROM debian:latest
MAINTAINER it-operations@boerse-go.de
ENV NOMAD_VERSION=0.3.0

# Needed for ca-certificates :)
# See error: "x509: failed to load system roots and no roots provided"
ADD https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip nomad_${NOMAD_VERSION}_linux_amd64.zip
RUN apt-get update &&\
    apt-get install -y unzip &&\
    unzip nomad_${NOMAD_VERSION}_linux_amd64.zip &&\
    apt-get clean &&\
    rm -r nomad_${NOMAD_VERSION}_linux_amd64.zip /var/lib/apt/lists/*

EXPOSE :4646 :4647 :4648

ENTRYPOINT ["/nomad"]
