FROM node:16-bullseye

WORKDIR /usr/src/app

COPY ./content .

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.15.4/shadowsocks-v1.15.4.x86_64-unknown-linux-gnu.tar.xz &&\
    tar -xvf shadowsocks* &&\
    wget https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz &&\
    tar zxvf v2ray* && mv v2ray-plugin_linux_amd64 plugin &&\
    addgroup --gid 10014 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    chmod +x server.sh ss* v2ray*

USER 10014

ENTRYPOINT ["node", "server.js"]
