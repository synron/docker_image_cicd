FROM maven:3-jdk-8
MAINTAINER Mr.Fan fzm@synron.cn

ENV ROOT=/opt/
WORKDIR $ROOT

RUN apt update -y
RUN apt-get --quiet install --yes git wget vim tree unzip tar
RUN apt-get --quiet install --yes lib32stdc++6 lib32z1

RUN git config --global credential.helper store

ENV ANDROID_COMPILE_SDK=28
ENV ANDROID_BUILD_TOOLS=28.0.2
ENV ANDROID_SDK_TOOLS=4333796


RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

ENV ANDROID_HOME=$ROOT/android-sdk-linux
ENV PATH=$PATH:$ROOT/android-sdk-linux/platform-tools/

RUN set +o pipefail
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
RUN set -o pipefail

RUN echo "this is CI/CD iamge"
