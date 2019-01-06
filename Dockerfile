FROM maven:3-jdk-8
MAINTAINER Mr.Fan fzm@synron.cn

ENV ROOT=/opt/
WORKDIR $ROOT

CMD apt update -y
CMD apt-get --quiet install --yes git wget vim tree unzip tar
CMD apt-get --quiet install --yes lib32stdc++6 lib32z1

CMD git config --global credential.helper store

ENV ANDROID_COMPILE_SDK=28
ENV ANDROID_BUILD_TOOLS=28.0.2
ENV ANDROID_SDK_TOOLS=4333796


CMD wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
CMD unzip -d android-sdk-linux android-sdk.zip
CMD echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
CMD echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
CMD echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

CMD echo 'ANDROID_HOME=$PWD/android-sdk-linux' >> ~/.bashrc
CMD echo 'PATH=$PATH:$PWD/android-sdk-linux/platform-tools/' >> ~/.bashrc
CMD source ~/.bashrc

CMD set +o pipefail
CMD yes | android-sdk-linux/tools/bin/sdkmanager --licenses
CMD set -o pipefail

