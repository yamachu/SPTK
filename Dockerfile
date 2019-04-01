# automake 1.15があるのが現状18.04
# https://ubuntu.pkgs.org/18.04/ubuntu-main-amd64/automake_1.15.1-3ubuntu2_all.deb.html
FROM ubuntu:18.04

ARG TAG=master

RUN apt-get update \
    && apt-get install -y build-essential autoconf automake libtool git csh \
    && git clone https://github.com/yamachu/SPTK.git \
    && cd SPTK \
    && git checkout $TAG \
    && ./configure --prefix=/sptk --exec-prefix=/sptk \
    && make \
    && make install 

FROM frolvlad/alpine-glibc:alpine-3.9

COPY --from=0 /sptk /sptk
ENV PATH $PATH:/sptk/bin
