#!/bin/bash
x=1
while [ $x -le 5 ]
do
curl -XPOST https://token-generator.artifactory.home.com/api/docker-stc/generateToken -u \$USERPASS > token.json
TOKEN=\$(cat token.json | grep access_token |cut -d ':' -f2 | cut -d '"' -f2)
                             
base64=$(echo "$Token" |base64)
kubectl patch secret my-secret -p "{\"data\":{\"key1\":\"${base64}\"}}"
kubectl patch secret my-secret -p "{\"data\":{\"key1\":\"${base64}\"}}" -n ingress-nginx
sleep 20
done
