# Using debian because busybox:glibc does not include libpthread.so
FROM debian:latest
MAINTAINER it-operations@boerse-go.de
ENV TOOL=nomad \
    VERSION=0.3.1 \
    SHA256=467fcebe9f0a349063a4f16c97cb71d9c57451fc1f10cdb2292761cf56542671

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
CMD ["--help"]
