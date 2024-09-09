#!/bin/bash

# Define repository URLs and target directories
USER_SERVICE_REPO="https://github.com/DavidBlanco2825/mindhub-user-service.git"
TASK_SERVICE_REPO="https://github.com/DavidBlanco2825/mindhub-task-service.git"
GATEWAY_SERVICE_REPO="https://github.com/DavidBlanco2825/mindhub-gateway-service.git"
EUREKA_SERVER_REPO="https://github.com/DavidBlanco2825/mindhub-eureka-server.git"

# Define target directories for each microservice
USER_SERVICE_DIR="user-service"
TASK_SERVICE_DIR="task-service"
GATEWAY_SERVICE_DIR="gateway-service"
EUREKA_SERVER_DIR="eureka-server"

# Function to clone repositories
clone_repo() {
  local repo_url=$1
  local target_dir=$2
  
  # Check if the directory already exists
  if [ -d "$target_dir" ]; then
    echo "Directory $target_dir already exists. Pulling latest changes."
    cd "$target_dir"
    git pull || { echo "Failed to pull $repo_url"; exit 1; }
    cd ..
  else
    echo "Cloning $repo_url into $target_dir"
    git clone "$repo_url" "$target_dir" || { echo "Failed to clone $repo_url"; exit 1; }
  fi
}

# Start cloning
echo "Cloning repositories..."
clone_repo "$USER_SERVICE_REPO" "$USER_SERVICE_DIR"
clone_repo "$TASK_SERVICE_REPO" "$TASK_SERVICE_DIR"
clone_repo "$GATEWAY_SERVICE_REPO" "$GATEWAY_SERVICE_DIR"
clone_repo "$EUREKA_SERVER_REPO" "$EUREKA_SERVER_DIR"

# Output success message
echo "Repositories cloned successfully."

# Check if repositories were cloned
if [ ! -d "user-service" ] || [ ! -d "task-service" ] || [ ! -d "eureka-server" ] || [ ! -d "gateway-service" ]; then
  echo "Error: One or more repositories were not cloned. Exiting."
  exit 1
fi

# Run Docker Compose to build and start the services
echo "Running docker-compose up --build..."
docker compose -f docker-compose.yml up --build -d