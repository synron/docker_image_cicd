FROM alpine

MAINTAINER Mr.Fan fzm@synron.cn

WORKDIR /opt

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add ca-certificates openjdk8-jre-base@community && \
    apk del ca-certificates && \
    rm -rf /tmp/* /var/cache/apk/*

#解决时区错乱的问题
RUN cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


CMD ["sh"]
