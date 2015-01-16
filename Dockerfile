FROM ubuntu:14.04
MAINTAINER Jose Coelho <jacoelho@outlook.com>

ADD . /

RUN /build.sh && \
  rm -fr /setup && \
  rm /build.sh

CMD ["/sbin/init"]