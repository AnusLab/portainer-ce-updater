# Portainer Auto-Update Script

A beautiful shell script that automatically updates Portainer CE to the latest version with a nice visual interface.

## Features

- 🎨 Beautiful progress interface with color-coded steps
- ✅ Automatic container management (stop, remove, pull, create)
- 🔒 Root permission check
- 🚀 Error handling and status messages
- 📝 Maintains all Portainer volumes and data

## Quick Update (One Command)

```bash
curl -s https://raw.githubusercontent.com/AnusLab/portainer-ce-updater/main/update_portainer.sh | sudo bash
```

## Manual Installation

1. Download the script:
```bash
wget https://raw.githubusercontent.com/AnusLab/portainer-ce-updater/main/update_portainer.sh
```

2. Make it executable:
```bash
chmod +x update_portainer.sh
```

3. Run with sudo:
```bash
sudo ./update_portainer.sh
```

## Requirements

- Docker installed and running
- Bash shell
- Root/sudo access

## Access Portainer

After running the script, Portainer will be available at:
- HTTPS: `https://<YOUR-SERVER-IP>:9443`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
