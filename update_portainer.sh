#!/bin/bash

# Colors and formatting
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Function to display step header
display_step() {
    echo -e "\n${BLUE}${BOLD}[Step $1/${TOTAL_STEPS}]${NC} $2"
    echo -e "${YELLOW}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Function to display success message
display_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

# Total number of steps
TOTAL_STEPS=4

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${YELLOW}${BOLD}⚠️  Please run this script as root (sudo)${NC}"
    exit 1
fi

# Step 1: Stop Portainer
display_step "1" "Stopping Portainer container"
if docker stop portainer; then
    display_success "Portainer container stopped successfully"
else
    echo "Warning: Could not stop Portainer container. It might not be running."
fi

# Step 2: Remove Portainer container
display_step "2" "Removing Portainer container"
if docker rm portainer; then
    display_success "Portainer container removed successfully"
else
    echo "Warning: Could not remove Portainer container. It might not exist."
fi

# Step 3: Pull latest Portainer image
display_step "3" "Pulling latest Portainer image"
if docker pull portainer/portainer-ce:latest; then
    display_success "Latest Portainer image pulled successfully"
else
    echo "Error: Failed to pull latest Portainer image"
    exit 1
fi

# Step 4: Start new Portainer container
display_step "4" "Starting new Portainer container"
if docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name=portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest; then
    display_success "New Portainer container started successfully"
else
    echo "Error: Failed to start new Portainer container"
    exit 1
fi

echo -e "\n${GREEN}${BOLD}✨ Portainer has been successfully updated!${NC}"
echo -e "${BLUE}You can access Portainer at:${NC}"
echo -e "🔒 HTTPS: ${BOLD}https://localhost:9443${NC}"
echo -e "🌐 HTTP:  ${BOLD}http://localhost:8000${NC}\n" 