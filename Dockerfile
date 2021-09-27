##### Build stage #####

FROM debian:stretch-slim as builder

RUN apt -qq update && \
    apt -qq install -y --no-install-recommends ca-certificates curl git build-essential cmake clang libssl-dev openssl

WORKDIR /root/utsa
COPY . .
RUN mkdir build && cd build && cmake .. -DBUNDLE_CIVETWEB=ON && make

###### Final stage #####

FROM debian:stretch-slim

RUN apt update && \
    apt install -y --no-install-recommends ca-certificates libssl-dev

RUN groupadd -r utsa && useradd -r -g utsa utsa
RUN mkdir /etc/utsa && chown utsa:utsa /etc/utsa && mkdir /opt/utsa
VOLUME /etc/utsa

COPY --from=builder /root/utsa /opt/utsa
RUN ln -s /opt/utsa/build/utsa /usr/local/bin; \
    chown -R utsa:utsa /opt/utsa
WORKDIR /opt/utsa

EXPOSE 2020

ENTRYPOINT ["utsa"]
