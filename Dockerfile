FROM google/nodejs
MAINTAINER ShoppinPal <founders@shoppinpal.com>

# set the working directory
WORKDIR /app

# add relevant sources into the docker container
ADD package.json /app/
ADD client /app/client
ADD server /app/server

RUN npm install
RUN export NODE_ENV=development
#ONBUILD ADD . /app
#ONBUILD ADD node_modules /app/node_modules

RUN set :bind, '0.0.0.0'
EXPOSE 8080
#CMD []
RUN pwd
RUN ls -alrt
ENTRYPOINT ["/nodejs/bin/npm", "start"]
