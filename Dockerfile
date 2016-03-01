FROM debian:latest
MAINTAINER it-operations@boerse-go.de
ENV NOMAD_VERSION=0.3.0 \
    NOMAD_SHA256=530e5177cecd65d36102953099db19ecdbfa62b3acf20a0c48e20753a597f28e

ADD https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip nomad_${NOMAD_VERSION}_linux_amd64.zip
RUN echo "${NOMAD_SHA256} nomad_${NOMAD_VERSION}_linux_amd64.zip" | sha256sum -c &&\
    apt-get update &&\
    apt-get install -y unzip &&\
    unzip nomad_${NOMAD_VERSION}_linux_amd64.zip &&\
    apt-get clean &&\
    rm -r nomad_${NOMAD_VERSION}_linux_amd64.zip /var/lib/apt/lists/*

EXPOSE :4646 :4647 :4648

ENTRYPOINT ["/nomad"]
