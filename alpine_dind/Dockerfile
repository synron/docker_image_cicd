
FROM docker:edge

MAINTAINER Mr.Fan fzm@synron.cn

RUN apk update

RUN apk add --no-cache ca-certificates wget && \
    apk add --no-cache curl bash tree tzdata && \

#安装 java
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
RUN tar -xzvf jdk-8u191-linux-x64.tar.gz -C /usr/local/ && \
    rm -f jdk-8u191-linux-x64.tar.gz*
 
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
    apk add glibc-2.28-r0.apk && \
    rm -f glibc-2.28-r0.apk*
    
#解决时区错乱的问题
RUN cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
 
#安装Maven
RUN MAVEN_VERSION=3.5.4 && \
    wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION /usr/lib/maven


ENV JAVA_HOME /usr/local/jdk1.8.0_191
ENV MAVEN_HOME /usr/lib/maven
ENV PATH $PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
