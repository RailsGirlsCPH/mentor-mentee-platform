
FROM node:current-alpine

RUN apk add --update tini 
WORKDIR /app

# Warning removed package-lock.json because it 
# requires a newer webpack but the lock file installs 4.41.5
#when json fixed should be able to copy lock file here too.

COPY package.json ./


RUN npm install \
    && npm cache clean --force

COPY . ./

CMD ["npm", "start"]


