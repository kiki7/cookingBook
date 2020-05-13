#!/bin/bash

mongod --dbpath /data/menus &
sleep 3
npm run start &

mongoimport -d menus -c recipes /src/docs/recipes.json
mongoimport -d menus -c users /src/docs/users.json

exit