FROM centos

MAINTAINER Mr.Fan fzm@synron.cn

#Init
WORKDIR /opt/

RUN yum update -y && yum install -y git vim wget unzip tree tar && \
    yum install -y zlib-1.2.7-17.el7.i686 glibc.i686 libstdc++.so.6 && \
    mkdir -p ~/.m2/ ~/.gradle ~/.android

# ENV
ENV JAVA_HOME /usr/local/jdk
ENV MAVEN_HOME /usr/lib/maven
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:${ANDROID_HOME}/platform-tools/
ENV DOCKER_HOST tcp://docker:2375

# Local
ENV LC_ALL zh_CN.utf8 #设置环境变量 
RUN rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    yum -y install kde-l10n-Chinese && \
    yum -y reinstall glibc-common && \
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 && \
    yum groupinstall -y "fonts"

# Docker
RUN DOCKER_CHANNEL=stable && \
    DOCKER_VERSION=18.06.1 && \
    DOCKER_ARCH='x86_64'; && \
    wget -q -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${DOCKER_ARCH}/docker-${DOCKER_VERSION}-ce.tgz"; && \
    tar -xvf docker.tgz -C ./ && \
    \cp -rf docker/* /usr/local/bin/ && \
    \rm -rf docker* && \
    dockerd --version && \
    docker --version && \
    wget -q -O modprobe.sh https://raw.githubusercontent.com/synron/docker_images/master/dind_ide/modprobe.sh && \
    chmod +x modprobe.sh && \
    \cp -rf modprobe.sh /usr/local/bin/modprobe && \
    \rm -rf *

RUN mkdir -p /etc/docker && \
    echo '{ "registry-mirrors" : [ "https://migmfoxa.mirror.aliyuncs.com" ] }' > /etc/docker/daemon.json;
    
# Java
RUN wget -q --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz && \
    tar -xzf jdk-8u191-linux-x64.tar.gz -C /usr/local/ && \
    \mv -f /usr/local/jdk1.8.0_191 /usr/local/jdk && \
    \rm -rf *
    
# Maven
RUN MAVEN_VERSION=3.5.4 && \
    MS_URL=https://raw.githubusercontent.com/synron/docker_images/master/settings.xml && \
    wget -q -O ~/.m2/settings.xml ${MS_URL} && \
    wget -q http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    \mv -f apache-maven-$MAVEN_VERSION /usr/lib/maven && \
    \rm -rf *
RUN MS_URL=https://raw.githubusercontent.com/synron/docker_images/master/settings.xml && \
    mkdir -p ~/.m2/ && wget -q -O ~/.m2/settings.xml ${MS_URL}
    
# Android
RUN ANDROID_COMPILE_SDK="28" && \
    ANDROID_BUILD_TOOLS="28.0.2" && \
    ANDROID_SDK_TOOLS="4333796" && \
    URL_ANDROID_SDK=https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip && \
    wget -q -O android-sdk.zip ${URL_ANDROID_SDK} && \
    unzip -q -o -d android-sdk-linux android-sdk.zip && \rm -rf android-sdk.zip && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null && \
    yes | android-sdk-linux/tools/bin/sdkmanager --licenses
 

# Complete
ENTRYPOINT ["/usr/sbin/init"]
