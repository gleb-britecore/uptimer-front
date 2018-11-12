# Stage 0, based on Node.js, to build and compile Angular
#FROM       node:8.11.3 as node
FROM nginx:1.15

MAINTAINER Intuitive Web Solutions

RUN apt-get update
RUN apt-get install -y wget


# Installs Node.js
ENV NODE_VERSION 8.11.3
RUN cd && \
    wget -q http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz && \
    tar -xzf node-v${NODE_VERSION}-linux-x64.tar.gz && \
    mv node-v${NODE_VERSION}-linux-x64 /opt/node && \
    rm node-v${NODE_VERSION}-linux-x64.tar.gz
ENV PATH ${PATH}:/opt/node/bin


RUN node -v
RUN npm -v

RUN        mkdir /var/src
WORKDIR    /var/src

COPY       package.json /var/src/package.json
RUN        npm install --unsafe-perm

#ARG API_ROOT
#ENV API_ROOT=$API_ROOT
COPY       . /var/src/
#RUN         export API_ROOT=$API_ROOT

RUN         npm run build

RUN env
# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
ADD       run-in-docker.sh /var/src/run_in_docker
ADD       before-docker-run.js /usr/share/nginx/html/before-docker-run.js

WORKDIR    /var/src/dist
RUN    mv -v * /usr/share/nginx/html



COPY    ./deploy/nginx-custom.conf /etc/nginx/conf.d/default.conf


CMD (/var/src/run-in-docker.sh)