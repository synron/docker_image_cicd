FROM ubuntu

MAINTAINER Mr.Fan fzm@synron.cn

#Init
WORKDIR /opt/

RUN yum update -y && yum install git vim wget unzip tree && \
  yum install -y lib32stdc++6 lib32z1 && \
  mkdir -p ~/.m2/ ~/.gradle ~/.android

# ENV

ENV JAVA_HOME /usr/local/jdk
ENV MAVEN_HOME /usr/lib/maven
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:${ANDROID_HOME}/platform-tools/

# Docker


RUN mkdir -p /etc/docker && \
    echo '{ "registry-mirrors" : [ "https://migmfoxa.mirror.aliyuncs.com" ] }' > /etc/docker/daemon.json;
    
# Java

# Maven

# Android

RUN ANDROID_COMPILE_SDK="28" && \
    ANDROID_BUILD_TOOLS="28.0.2" && \
    ANDROID_SDK_TOOLS="4333796" && \
    MS_URL=https://raw.githubusercontent.com/synron/docker_image_cicd/master/settings.xml && \
    wget --output-document=settings.xml ${MS_URL} && \mv -f settings.xml ~/.m2/ && \
    URL_ANDROID_SDK=https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip && \
    wget --output-document=android-sdk.zip ${URL_ANDROID_SDK} && \
    unzip -d android-sdk-linux android-sdk.zip && \rm -rf android-sdk.zip && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null && \
    echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null && \
    yes | android-sdk-linux/tools/bin/sdkmanager --licenses
 

# Complete

ENTRYPOINT ["bash"]
