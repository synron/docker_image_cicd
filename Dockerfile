FROM ubuntu:latest

MAINTAINER Mr.Fan fzm@synron.cn

ENV ROOT=/opt/
WORKDIR $ROOT


ENV M2_HOME /opt/maven
ENV PATH $PATH:$M2_HOME/bin

ENV ANDROID_COMPILE_SDK 28
ENV ANDROID_BUILD_TOOLS 28.0.2
ENV ANDROID_SDK_TOOLS 4333796

ENV ANDROID_HOME $ROOT/android-sdk-linux
ENV PATH $PATH:$ROOT/android-sdk-linux/platform-tools/

ENV JAVA_HOME /usr/java/jdk1.8.0_191-amd64/
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH $JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH $JAVA_HOME/bin:$JRE_HOME/bin:$PATH

RUN apt-get update -y && \
    apt-get install -y git wget vim tree unzip tar && \
    apt-get install -y lib32stdc++6 lib32z1 && \
    URL_JAVA=http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm && \
    URL_MAVEN=http://mirror.bit.edu.cn/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.zip && \
    URL_ANDROID_SDK=https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip && \
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $URL_JAVA && \
    yum install -y jdk-8u191-linux-x64.rpm && rm -rf jdk-8u191-linux-x64.rpm && \
    wget --quiet --output-document=maven.zip $URL_MAVEN && \
    unzip -d maven maven.zip && \
    wget --quiet --output-document=android-sdk.zip $URL_ANDROID_SDK && \
    unzip -d android-sdk-linux android-sdk.zip && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null && \
    yes | android-sdk-linux/tools/bin/sdkmanager --licenses


ENV PATH $PATH
