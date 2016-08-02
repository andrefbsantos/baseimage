FROM ubuntu:14.04.2
MAINTAINER Jose Coelho <jacoelho@outlook.com>

RUN apt-get update -y -qq && apt-get install -y -qq software-properties-common git

ADD . /tmp

RUN /tmp/bootstrap.sh

CMD ["/sbin/my_init"]
