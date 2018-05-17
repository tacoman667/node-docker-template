FROM node:alpine

RUN apk update \
  && apk add --no-cache git openssh-client bash alpine-sdk

# needed for installing yarn 1.6.0+ and utilizing workspaces
RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]/edge/g' /etc/apk/repositories
RUN apk add --no-cache yarn

RUN mkdir /node_modules
WORKDIR /app

RUN yarn global add nodemon

COPY package.json .
RUN yarn install

COPY . /app

EXPOSE 3000

CMD nodemon