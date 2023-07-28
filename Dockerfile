FROM debian AS build-env
RUN apt-get update
RUN apt-get install -y build-essential git
RUN git clone https://github.com/esnet/iperf /src
WORKDIR /src
RUN ./configure --enable-static "LDFLAGS=--static" --disable-shared --without-openssl
RUN make

FROM scratch AS iperf3
COPY --from=0 /src/src/iperf3 /iperf3
ENTRYPOINT ["/iperf3"]
EXPOSE 5201/tcp 5201/udp
CMD ["-s"]

