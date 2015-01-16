FROM ubuntu:14.04
MAINTAINER Jose Coelho <jacoelho@outlook.com>

ADD . /

RUN /build.sh 


CMD ["/sbin/init"]