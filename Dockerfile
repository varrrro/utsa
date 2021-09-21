##### Build stage #####

FROM debian:stretch-slim as builder

RUN apt -qq update && \
    apt -qq install -y --no-install-recommends ca-certificates curl git build-essential cmake clang libssl-dev openssl

WORKDIR /root
COPY . .
RUN cmake . -DBUNDLE_CIVETWEB=ON && make

###### Final stage #####

FROM debian:stretch-slim

RUN apt update && \
    apt install -y --no-install-recommends ca-certificates libssl-dev

RUN groupadd -r uts-server && useradd -r -g uts-server uts-server
RUN mkdir /etc/uts-server && chown uts-server:uts-server /etc/uts-server && mkdir /opt/uts-server
VOLUME /etc/uts-server

COPY --from=builder /root/uts-server /opt/uts-server
RUN ln -s /opt/uts-server/uts-server /usr/local/bin; \
    chown -R uts-server:uts-server /opt/uts-server
WORKDIR /opt/uts-server

EXPOSE 2020

ENTRYPOINT ["uts-server"]
