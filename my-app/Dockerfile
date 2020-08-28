# based on https://mherman.org/blog/dockerizing-a-react-app/

# pull official base image
FROM node:13.12.0-alpine

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
# Warning removed package-lock.json because it 
# requires a newer webpack but the lock file installs 4.41.5
# when json fixed should be able to copy lock file here too. 
#COPY package-lock.json ./
RUN npm install --silent

COPY . ./

CMD ["npm", "start"]


