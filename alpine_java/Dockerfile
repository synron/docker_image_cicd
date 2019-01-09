
FROM alpine

MAINTAINER Mr.Fan fzm@synron.cn

WORKDIR /opt

RUN apk update && apk upgrade

RUN apk add --no-cache ca-certificates tzdata && \
    apk del ca-certificates

#解决时区错乱的问题
RUN cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#安装 java
RUN wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
RUN tar -xzf jdk-8u191-linux-x64.tar.gz && \
    \rm -f jdk-8u191-linux-x64.tar.gz* && \
    \mv -f jdk1.8.0_191/jre /usr/local/jre && \
    \rm -rf jdk1.8.0_191

#安装 glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
    apk add glibc-2.28-r0.apk && \
    rm -f glibc-2.28-r0.apk*

RUN rm -rf /tmp/* /var/cache/apk/*

ENV JAVA_HOME /usr/local/jre
ENV PATH $PATH:$JAVA_HOME/bin

CMD ["sh"]
