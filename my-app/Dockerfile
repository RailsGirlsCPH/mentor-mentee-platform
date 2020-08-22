FROM node:current-alpine

RUN apk add --update tini \
    && mkdir -p /usr/src/app

# removed package-lock.json because it 
# requires a newer webpack but the lock file installs 4.41.5
#when json fixed should be 
COPY package.json ./

#COPY package.json .

RUN npm install \
    && npm cache clean --force

#can be changed to . ./ when json lock fixed. 
COPY . ./

CMD ["npm", "start"]


