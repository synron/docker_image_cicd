FROM maven:3-jdk-8

MAINTAINER Mr.Fan fzm@synron.cn

WORKDIR /opt/

RUN curl -O https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar zxvf docker-latest.tgz \
    && \cp -rf docker/docker /usr/local/bin/ \
    && \rm -rf docker docker-latest.tgz
    
RUN apt-get update -y && \
    apt-get install -y git wget vim tree unzip tar && \
    apt-get install -y lib32stdc++6 lib32z1 && \
    mkdir -p ~/.m2/ mkdir -p ~/.gradle && mkdir -p ~/.android
    
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
 

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:/opt/android-sdk-linux/platform-tools/

ENV PATH $PATH
