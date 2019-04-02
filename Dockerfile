FROM ubuntu:18.04

ARG TAG=master

RUN apt-get update \
    && apt-get install -y build-essential autoconf automake libtool git csh \
    && git clone https://github.com/yamachu/SPTK.git \
    && cd SPTK \
    && git checkout $TAG \
    && autoreconf -vfi \
    && ./configure --prefix=/sptk --exec-prefix=/sptk \
    && make \
    && make install 

FROM frolvlad/alpine-glibc:alpine-3.9

COPY --from=0 /sptk /sptk
ENV PATH $PATH:/sptk/bin
