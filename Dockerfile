FROM debian:latest
MAINTAINER it-operations@boerse-go.de
ENV TOOL=nomad \
    VERSION=0.3.0 \
    SHA256=530e5177cecd65d36102953099db19ecdbfa62b3acf20a0c48e20753a597f28e

# By using ADD there is no need to install wget or curl
ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    apt-get update -y &&\
    apt-get install -y unzip &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip &&\
    apt-get clean && rm -r /var/lib/apt/lists/*

EXPOSE :4646 :4647 :4648

ENTRYPOINT ["/nomad"]
