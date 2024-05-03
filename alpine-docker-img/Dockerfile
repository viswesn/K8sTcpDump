# Use the Alpine Linux as the base image
FROM alpine:3.19

RUN set -ex \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    bash \
    bridge-utils \
    curl \
    dhcping \
    iperf \
    iperf3 \
    iptables \
    ltrace \
    nmap \
    tcpdump \
    docker 


COPY run.sh /root/

USER root
WORKDIR /root
ENV HOSTNAME cloud-docker

CMD ["bash"]
