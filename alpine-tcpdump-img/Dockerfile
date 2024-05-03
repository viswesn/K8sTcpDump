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
    tcpdump

USER root
WORKDIR /root
ENV HOSTNAME netshoot

CMD ["bash"]
