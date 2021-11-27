FROM alpine:3.14.2

# Use ARM based device (cubox-i) to build and push container
# docker build -t docker-sane .


RUN apk add --update --no-cache bash sane-saned sane-utils sane-backend-epson sane-backend-epson2 busybox-extras && \
    echo "6566 stream tcp nowait root.root /usr/sbin/saned saned" >/etc/inetd.conf && \
    addgroup saned lp

ADD entrypoint.sh /entrypoint.sh

EXPOSE 6566-6570
ENV DATA_PORT_RANGE="6567-6570" ALLOW_HOSTS="192.168.178.0/24"

ENTRYPOINT [ "/entrypoint.sh" ]

# docker tag docker-sane:latest hcdaniel/docker-sane:2.0
# docker login
# docker push hcdaniel/docker-sane:2.0

