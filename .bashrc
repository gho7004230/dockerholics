# run 'source ~/.bashrc' to load latest changes in current session

# ALIASES #####################################################
# Note that these aliases do not use the latest docker compose cli commands as Synology docker is a number of versions behind.
# If you are running the latest Docker engine on linux, then substitute 'docker-compose' for 'docker compose'

# Set docker aliases
alias cdkr='cd /volume1/docker'
alias list='docker ps -a --format "table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}" | (read -r; printf "%s\n" "$REPLY"; sort -k 1 )'
alias down='docker-compose down -v'
alias pull='docker-compose pull'
alias up='docker-compose up -d'
alias inspect='docker inspect'
alias create='docker-compose up --no-start'
alias stop='docker stop'
alias start='docker start'
alias prune='docker system prune -a --volumes'
alias del='docker rm'

# FUNCTIONS ####################################################

# Restarts a container
#
cycle() {
  stop $1
  start $1
}

# pulls a image and then creates and starts it
pullup() {
  pull $1
  up $1
}

# Opens a bash shell, given a supplied container name
#
termb() {
  docker exec -it $1 /bin/bash
}

# Opens a ash shell, given a supplied container name
#
terma() {
  docker exec -it $1 /bin/ash
}

# stops and deletes a container
#
mdk() {
  stop $1
  del $1
}

# Shows 'port in use' details for a supplied port number
#
piu() {
  sudo netstat -plan | grep ":$1"
}

# ENVIRONMENT SETTINGS ##########################################
#
# Helps avoid timeouts for large yaml scripts
export DOCKER_CLIENT_TIMEOUT=360
export COMPOSE_HTTP_TIMEOUT=360