# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero -p 18080:18080 -p 18081:18081 --name=monerod -td kannix/monero-full-node
FROM ubuntu:18.04 AS build

RUN apt-get update
RUN apt-get install -y curl wget xz-utils
ENV RYO_VERSION=0.4.0.0 RYO_SHA256=4da626d3a051d4ffc149cfb4695ad512ff018c223a3050985ad1aa28e3834325

WORKDIR /root

RUN wget https://github.com/ryo-currency/ryo-currency/releases/download/$RYO_VERSION/ryo-linux-x64-$RYO_VERSION.tar.xz &&\
  echo "$RYO_SHA256  ryo-linux-x64-$RYO_VERSION.tar.xz" | sha256sum -c - &&\
  tar -xJvf ryo-linux-x64-$RYO_VERSION.tar.xz &&\
  rm ryo-linux-x64-$RYO_VERSION.tar.xz &&\
  cp ./ryo-linux-x64-$RYO_VERSION/ryod . &&\
  rm -r ryo-*
  
FROM ubuntu:18.04

RUN useradd -ms /bin/bash ryo
USER ryo
WORKDIR /home/ryo

COPY --chown=ryo:ryo --from=build /root/ryod /home/ryo/ryod

# blockchain location
VOLUME /home/ryo/.ryo

EXPOSE 12210 12211

ENTRYPOINT ["./ryod"]
CMD ["--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind", "--non-interactive"]
