
FROM node:current-alpine

RUN apk add --update tini \
    && mkdir -p /usr/src/app

COPY package.json .


RUN rm package-lock.json \
    && npm install \
    && npm cache clean --force

COPY . .

CMD ["npm", "start"]

