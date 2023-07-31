FROM node:16-bullseye

WORKDIR /usr/src/app

COPY ./content .

ENV PM2_HOME=/tmp

RUN set -x \
    && yarn install \
    && yarn global add pm2 \
    && wget https://github.com/icpz/open-snell/releases/download/v3.0.1/snell-server-linux-amd64.zip \
    && unzip snell* \
    && addgroup --gid 10014 choreo \
    && adduser --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser \
    && usermod -aG sudo choreouser 

USER 10014

CMD [ "yarn", "start" ]
