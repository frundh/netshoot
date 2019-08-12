FROM mcr.microsoft.com/dotnet/core/sdk:3.0

RUN set -ex; \
    update-ca-certificates; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    apache2-utils \
    bash \
    bird \
    bridge-utils \
    curl \
    dhcping \
    dnsutils \
    ethtool \
    file\
    fping \
    git \
    iftop \
    iperf \
    iproute2 \
    iptables \
    iptraf-ng \
    iputils-arping \
    iputils-clockdiff \
    iputils-ping \
    iputils-tracepath \    
    ipvsadm \
    ldnsutils \
    mtr \
    net-tools \
    netcat-openbsd \
    nftables \
    ngrep \
    nano \
    nmap \
    openssl \
    python2 \
    ranger \
    scapy \
    snmp \
    socat \
    strace \
    tar \
    tcpdump \
    tcptraceroute \
    telnet \
    util-linux \
    vim; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

# Installing ctop - top-like container monitor
RUN wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 -O /usr/local/bin/ctop && chmod +x /usr/local/bin/ctop

# Installing gRPCurl
RUN wget -qO- https://github.com/fullstorydev/grpcurl/releases/download/v1.2.1/grpcurl_1.2.1_linux_x86_64.tar.gz | tar xzvf - -C /usr/local/bin/ grpcurl && chmod +x /usr/local/bin/grpcurl

# Installing calicoctl
ARG CALICOCTL_VERSION=v3.3.1
RUN wget https://github.com/projectcalico/calicoctl/releases/download/${CALICOCTL_VERSION}/calicoctl && chmod +x calicoctl && mv calicoctl /usr/local/bin

# Netgen
ADD netgen.sh /usr/local/bin/netgen

# Settings
ADD motd /etc/motd
ADD profile  /etc/profile

CMD ["/bin/bash","-l"]
