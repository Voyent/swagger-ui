#!/usr/bin/env bash

REMOTE_HOST=web.da
REMOTE_DIR=/usr/share/nginx/html/static/api-docs

#echo "Removing current dist directory..."
#rm -rf ./dist

#echo "Installing dependencies..."
#npm install
#

echo "Building..."
npm run build

echo "Compressing..."
cd ./dist
tar -zcf ../api-docs.tar.gz .
cd ..

echo "Copying to $REMOTE_HOST..."
scp api-docs.tar.gz ${REMOTE_HOST}:~/. || { exit 1; }

echo "Decompressing in $REMOTE_DIR..."
ssh ${REMOTE_HOST} "sudo tar -zxf /home/ubuntu/api-docs.tar.gz -C $REMOTE_DIR"

rm api-docs.tar.gz