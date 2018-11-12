#!/usr/bin/env bash

cd /usr/share/nginx/html

# Inject API_ROOT from env variables into start of index.html file
node before-docker-run.js


nginx -g "daemon off;"