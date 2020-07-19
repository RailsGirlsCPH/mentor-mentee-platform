
FROM node:current-alpine

EXPOSE 3000

RUN apk add --update tini \
    && mkdir -p /usr/src/app

COPY package.json .

COPY . .

RUN rm package-lock.json \
    && npm install \
    && npm cache clean --force

CMD ["npm", "start"]