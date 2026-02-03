# 🚀 Portainer CE LTS Auto-Updater

An elegant, zero-fuss shell script that updates **Portainer CE to the LTS image** with a polished, guided experience. Built for homelabs, small teams, and anyone who wants a reliable, repeatable update flow.

<div align="center">

![Shell](https://img.shields.io/badge/Shell-Bash-121011?logo=gnu-bash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)
![Portainer](https://img.shields.io/badge/Portainer-CE%20LTS-13BEF9)
![License](https://img.shields.io/badge/License-MIT-green)

</div>

---

## ✨ Why This Script Exists

Updating Portainer shouldn’t be a “copy-paste-and-hope” ritual. This script handles the full lifecycle in a clean, safe order—**stop → remove → pull LTS → run**—while preserving your data volume.

### Highlights

- 🎨 **Beautiful CLI UI** with color-coded steps and celebratory output
- ✅ **Automatic container management** (stop, remove, pull, start)
- 🔒 **Root guardrails** to avoid silent permission failures
- 🧠 **Smart messaging** so you always know what happened
- � **Data-safe** — keeps your existing `portainer_data` volume
- 🧩 **LTS channel** for stability-focused deployments

---

## ⚡ Quick Update (One Command)

```bash
curl -s https://raw.githubusercontent.com/AnusLab/portainer-ce-updater/main/update_portainer.sh | sudo bash
```

---

## 🛠️ Manual Installation

1. **Download the script**
   ```bash
   wget https://raw.githubusercontent.com/AnusLab/portainer-ce-updater/main/update_portainer.sh
   ```

2. **Make it executable**
   ```bash
   chmod +x update_portainer.sh
   ```

3. **Run with sudo**
   ```bash
   sudo ./update_portainer.sh
   ```

---

## ✅ Requirements

- Docker installed and running
- Bash shell
- Root/sudo access

---

## 📡 Access Portainer After Update

Portainer will be available at:

- **HTTPS (IPv4):** `https://<YOUR-SERVER-IPV4>:9443`
- **HTTPS (IPv6):** `https://[<YOUR-SERVER-IPV6>]:9443`

---

## 🔐 What It Actually Does

```text
1. Stop the running container (if any)
2. Remove the existing container (if any)
3. Pull portainer/portainer-ce:lts
4. Run the new container with the same ports and volume
```

---

## 🧯 Troubleshooting

- **Portainer not accessible?** Ensure ports **8000** and **9443** are open.
- **Docker permission error?** Run with `sudo` or as root.
- **IPv6 not shown?** Your host may not have a public IPv6 address assigned.

---

## 🤝 Contributing

PRs are welcome! If you have ideas to improve the UX, error handling, or output styling, open an issue or send a PR.

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
