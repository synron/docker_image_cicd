
FROM alpine

MAINTAINER Mr.Fan fzm@synron.cn

WORKDIR /opt

ENV LANG=C.UTF-8

RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

RUN apk update && apk upgrade

RUN apk add --no-cache ca-certificates tzdata git

#解决时区错乱的问题
RUN cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#安装 glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.28-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    wget -q \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    apk add --no-cache \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
     \rm -rf *.apk
     
RUN /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
        echo "export LANG=$LANG" > /etc/profile.d/locale.sh
        
#安装 java
RUN wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz && \
    tar -xzf jdk-8u191-linux-x64.tar.gz && \
    \rm -rf jdk-8u191-linux-x64.tar.gz* && \
#     \mv -f jdk1.8.0_191 /usr/local/jvm
    \mv -f jdk1.8.0_191/jre /usr/local/jvm && \
    \rm -rf jdk1.8.0_191 && \
    cd /usr/local/jvm && \
    \rm -rf lib/amd64/libjfxwebkit.so && \
    \rm -rf lib/ext/jfxrt.jar
    
RUN rm -rf /tmp/* /var/cache/apk/* 

ENV JAVA_HOME /usr/local/jvm
ENV PATH $PATH:$JAVA_HOME/bin

CMD ["sh"]
