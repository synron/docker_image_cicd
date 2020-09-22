FROM centos

MAINTAINER Mr.Fan fzm@synron.cn

#Init
WORKDIR /opt/

RUN yum update -y && yum install -y git vim wget curl tree unzip tar && \
    yum -y reinstall glibc-common && \
    yum groupinstall -y "fonts" && \
    mkdir -p ~/.m2/ ~/.gradle 

# ENV
ENV MAVEN_HOME /usr/lib/maven
ENV PATH $PATH:$MAVEN_HOME/bin
ENV DOCKER_HOST tcp://docker:2375


# Docker
RUN DOCKER_CHANNEL=stable && \
    DOCKER_VERSION=18.09.8 && \
    DOCKER_ARCH='x86_64' && \
    wget -q -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${DOCKER_ARCH}/docker-${DOCKER_VERSION}-ce.tgz" && \
    tar -xvf docker.tgz -C ./ && \
    \cp -rf docker/* /usr/local/bin/ && \
    dockerd --version && \
    docker --version && \
    wget -q -O modprobe.sh https://raw.githubusercontent.com/synron/docker_images/master/dind_ide/modprobe.sh && \
    chmod +x modprobe.sh && \
    \cp -rf modprobe.sh /usr/local/bin/modprobe && \
    \rm -rf * && \
    mkdir -p /etc/docker && \
    echo '{ "registry-mirrors" : [ "https://migmfoxa.mirror.aliyuncs.com" ] }' > /etc/docker/daemon.json;
    
# Java
RUN echo '[AdoptOpenJDK]' >> /etc/yum.repos.d/adoptopenjdk.repo \
    && echo 'name=AdoptOpenJDK' >> /etc/yum.repos.d/adoptopenjdk.repo \
    && echo 'baseurl=http://adoptopenjdk.jfrog.io/adoptopenjdk/rpm/centos/$releasever/$basearch' >> /etc/yum.repos.d/adoptopenjdk.repo \
    && echo 'enabled=1' >> /etc/yum.repos.d/adoptopenjdk.repo \
    && echo 'gpgcheck=1' >> /etc/yum.repos.d/adoptopenjdk.repo \
    && echo 'gpgkey=https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public' >> /etc/yum.repos.d/adoptopenjdk.repo \
    && yum -y install adoptopenjdk-8-hotspot \
    && java -version
    
# Maven
RUN MAVEN_VERSION=3.5.4 && \
    MS_URL=https://raw.githubusercontent.com/synron/docker_images/master/settings.xml && \
    wget -q -O ~/.m2/settings.xml ${MS_URL} && \
    wget -q http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    \mv -f apache-maven-$MAVEN_VERSION /usr/lib/maven && \
    \rm -rf * && \
    MS_URL=https://raw.githubusercontent.com/synron/docker_images/master/settings.xml && \
    mkdir -p ~/.m2/ && wget -q -O ~/.m2/settings.xml ${MS_URL}
 
# NodeJs && NPM && YARN
# https://github.com/nodesource/distributions#rpminstall
RUN PREFIX=/cache/.node/prefix/ && \
    CACHE=/cache/.node/cache/ && \
    mkdir -p ${PREFIX} ${CACHE} && \
    echo "prefix=${PREFIX}" >> ~/.npmrc && \
    echo "cache=${CACHE}" >> ~/.npmrc && \
    curl -sL https://rpm.nodesource.com/setup_current.x | bash - && \
    yum install -y nodejs && \
    node -v && \
    wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo && \
    yum install -y yarn && \
    yarn -v && \
    yum clean all

# FFmpeg
# RUN yum install epel-release -y && \
RUN    yum -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm \
    && yum -y install http://rpmfind.net/linux/epel/7/x86_64/Packages/s/SDL2-2.0.10-1.el7.x86_64.rpm \
    && yum -y install ffmpeg \
    && ffmpeg -h

# Complete
CMD ["/usr/bin/bash"]
