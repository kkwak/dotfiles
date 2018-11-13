HOST_USER_NAME="$(whoami)"
HOST_USER_ID="$(id -u)"
HOST_GROUP_ID="$(id -g)"

# .env is read by the docker-compose.yml
# there is no other way to pass down the params for user and group
cat > .env <<- EOM
UID=$HOST_USER_ID
GID=$HOST_GROUP_ID
USER_NAME=$HOST_USER_NAME
GROUP_NAME=staff
EOM

echo "Generated Environment File .env"
docker-compose up --build
