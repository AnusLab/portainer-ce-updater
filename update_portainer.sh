#!/bin/bash

# Colors and formatting
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Divider styles
DOUBLE_LINE="═══════════════════════════════════════════════════════════════════"
SINGLE_LINE="───────────────────────────────────────────────────────────────────"

# Function to display step header
display_step() {
    echo -e "\n${BLUE}${BOLD}${DOUBLE_LINE}${NC}"
    echo -e "${BLUE}${BOLD}[Step $1/${TOTAL_STEPS}]${NC} $2"
    echo -e "${BLUE}${BOLD}${DOUBLE_LINE}${NC}"
}

# Function to display success message
display_success() {
    echo -e "  ${GREEN}✓ $1${NC}"
    echo -e "${CYAN}${SINGLE_LINE}${NC}"
}

# Function to display warning message
display_warning() {
    echo -e "  ${YELLOW}⚠️  $1${NC}"
    echo -e "${CYAN}${SINGLE_LINE}${NC}"
}

# Function to display error message
display_error() {
    echo -e "  ${RED}❌ $1${NC}"
    echo -e "${CYAN}${SINGLE_LINE}${NC}"
}

# Print ASCII Art Banner
echo -e "${CYAN}${BOLD}"
echo '
     _                    _          _     
    / \   _ __  _   _ ___| |    __ _| |__  
   / _ \ | '\''_ \| | | / __| |   / _` | '\''_ \ 
  / ___ \| | | | |_| \__ \ |__| (_| | |_) |
 /_/   \_\_| |_|\__,_|___/_____\__,_|_.__/ 
                                           
 ╔═══════════════════════════════════════╗
 ║    Portainer CE Updater v1.1.0 (LTS)  ║
 ╚═══════════════════════════════════════╝
'
echo -e "${NC}"

# Print welcome message
echo -e "\n${GREEN}${BOLD}🚀 Portainer Auto-Update Script${NC}"
echo -e "${BLUE}Automatically updates Portainer CE to the LTS version${NC}"
echo -e "${YELLOW}${DOUBLE_LINE}${NC}"

# Total number of steps
TOTAL_STEPS=4

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "\n${YELLOW}${BOLD}⚠️  Error: Root Access Required${NC}"
    echo -e "${YELLOW}Please run this script as root (sudo)${NC}"
    echo -e "${YELLOW}${DOUBLE_LINE}${NC}"
    exit 1
fi

# Step 1: Stop Portainer
display_step "1" "Stopping Portainer container"
if docker stop portainer; then
    display_success "Portainer container stopped successfully"
else
    display_warning "Could not stop Portainer container. It might not be running."
fi

# Step 2: Remove Portainer container
display_step "2" "Removing Portainer container"
if docker rm portainer; then
    display_success "Portainer container removed successfully"
else
    display_warning "Could not remove Portainer container. It might not exist."
fi

# Step 3: Pull LTS Portainer image
display_step "3" "Pulling LTS Portainer image"
if docker pull portainer/portainer-ce:lts; then
    display_success "LTS Portainer image pulled successfully"
else
    display_error "Failed to pull LTS Portainer image"
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
    portainer/portainer-ce:lts; then
    display_success "New Portainer container started successfully"
else
    display_error "Failed to start new Portainer container"
    exit 1
fi

# Get IP addresses (prefer local, fallback to external)
IPV4_ADDRESS=$(ip -4 route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')
if [ -z "$IPV4_ADDRESS" ]; then
    IPV4_ADDRESS=$(hostname -I | awk '{print $1}')
fi
if [ -z "$IPV4_ADDRESS" ]; then
    IPV4_ADDRESS=$(curl -s -4 ifconfig.me)
fi

IPV6_ADDRESS=$(ip -6 addr show scope global 2>/dev/null | awk '/inet6/ {print $2}' | cut -d/ -f1 | head -n1)
if [ -z "$IPV6_ADDRESS" ]; then
    IPV6_ADDRESS=$(curl -s -6 ifconfig.me)
fi
IPV6_ADDRESS=$(echo "$IPV6_ADDRESS" | tr -d '[:space:]')

# Display completion message with style
echo -e "\n${GREEN}${BOLD}${DOUBLE_LINE}"
echo -e "✨ Portainer has been successfully updated!"
echo -e "${DOUBLE_LINE}${NC}"

echo -e "\n${BLUE}${BOLD}📡 Access Information${NC}"
echo -e "${YELLOW}${SINGLE_LINE}${NC}"
echo -e "${GREEN}🔒 HTTPS (IPv4):${NC} ${BOLD}https://${IPV4_ADDRESS}:9443${NC}"
if [ -n "$IPV6_ADDRESS" ]; then
    echo -e "${GREEN}🔒 HTTPS (IPv6):${NC} ${BOLD}https://${IPV6_ADDRESS}:9443${NC}"
fi

# Thank you message
echo -e "\n${BLUE}${BOLD}💝 Thank You${NC}"
echo -e "${YELLOW}${SINGLE_LINE}${NC}"
echo -e "${CYAN}Thank you for using our Portainer Auto-Update Script! 🙏${NC}"
echo -e "${CYAN}We hope this tool makes your Docker workflow smoother and more efficient.${NC}"
echo -e "${YELLOW}Star us on GitHub if you found this helpful! ⭐${NC}"
echo -e "${YELLOW}${DOUBLE_LINE}${NC}\n" 