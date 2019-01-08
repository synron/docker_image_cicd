
FROM docker:edge

#构建人联系方式*************************************************
MAINTAINER Mr.Fan fzm@synron.cn


 
#定义工作目录，个人理解就是用来存放自己资源的文件夹******************
#WORKDIR /usr/local
 
#COPY复制当前文件夹到镜像中的特定位置
#COPY语法：
#COPY ["<src>",... "<dest>"]  （推荐）特别适合路径中带有空格的情况
#COPY <src>... <dest>
#ADD 还支持通过URL从远程服务器读取资源并复制到镜像中
#语法
#ADD ["<src>",... "<dest>"]，特别适合路径中带有空格的情况
#ADD <src>... <dest>，特别适合路径中带有空格的情况
#COPY指令和ADD指令的用法非常相似，具体注意事项如下：
#源路径可以有多个
#源路径是相对于执行build的相对路径
#源路径如果是本地路径，必须是build上下文中的路径
#源路径如果是一个目录，则该目录下的所有内容都将被加入到容器，但是该目录本身不会
#目标路径必须是绝对路径，或相对于WORKDIR的相对路径
#目标路径如果不存在，则会创建相应的完整路径
#目标路径如果不是一个文件，则必须使用/结束
#路径中可以使用通配符
#满足同等功能的情况下，推荐使用COPY指令。ADD指令更擅长读取本地tar文件并解压缩
#无论是COPY还是ADD，源如果时候文件夹，则文件夹下面的所有内容都被加入到容器
#注意是文件夹下面的内容，不包括文件夹


RUN apk update

RUN apk add --no-cache ca-certificates wget && \
    apk add --no-cache curl bash tree tzdata && \

#安装 java
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie"  https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz
RUN tar -xzvf jdk-8u191-linux-x64.tar.gz -C /usr/local/ && \
    rm -f jdk-8u191-linux-x64.tar.gz*


#安装gclib ；解决时区问题
#RUN在镜像中运行命令，必须是基础镜像识别的命令
#Java是基于GUN Standard C library(glibc)，Alpine是基于MUSL libc(mini libc)  ，需要安装gclib库
#截止到目前最稳定的版本是2.28
 
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
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn


ENV JAVA_HOME /usr/local/jdk1.8.0_191
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
