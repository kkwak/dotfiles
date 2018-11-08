#!/bin/bash

USER_NAME="$(whoami)"
USER_ID="$(id -u)"
GROUP_ID="$(id -g)"

# .env is read by the docker-compose.yml
# there is no other way to pass down the params for user and group
cat > .env <<- EOM
USER=$USER_NAME
USER_ID=$USER_ID
GROUP_ID=$GROUP_ID
EOM

docker-compose up --build
