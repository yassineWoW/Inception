# 🐳 Inception - Docker Infrastructure Project

<div align="center">

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker_Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

**A complete containerized web infrastructure using Docker, featuring Nginx, WordPress, and MariaDB**

[Features](#-features) • [Architecture](#-architecture) • [Installation](#-installation) • [Usage](#-usage) • [Project Structure](#-project-structure)

</div>

---

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Architecture](#-architecture)
- [Technologies](#-technologies)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [Configuration](#-configuration)
- [Security](#-security)
- [Testing](#-testing)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

---

## 📖 About

**Inception** is a 42 School project that challenges students to build a complete web infrastructure using **Docker** and **Docker Compose**. The project focuses on understanding containerization, orchestration, networking, and system administration.

### 🎯 Project Goals

- ✅ Set up a multi-container Docker application
- ✅ Configure a secure NGINX web server with TLS
- ✅ Deploy WordPress with PHP-FPM
- ✅ Set up MariaDB database
- ✅ Implement proper networking and volumes
- ✅ Follow Docker and security best practices

---

## ✨ Features

### 🔒 Security
- **TLS 1.2/1.3 only** - Modern encryption standards
- **Self-signed SSL certificates** - HTTPS encryption
- **Non-root containers** - Enhanced security
- **Isolated networks** - Container segmentation

### 🏗️ Infrastructure
- **Custom Docker images** - Built from scratch (Debian Bullseye)
- **Multi-container orchestration** - Docker Compose
- **Persistent volumes** - Data persistence across restarts
- **Automatic restart** - High availability
- **Health checks** - Service monitoring

### 🌐 Services
- **Nginx** - Reverse proxy & web server
- **WordPress** - Content management system
- **MariaDB** - Relational database
- **PHP-FPM 7.4** - PHP processor

---

## 🏛️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Host Machine                         │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │              Docker Network (Bridge)                │    │
│  │                                                      │    │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────┐ │    │
│  │  │    Nginx     │  │  WordPress   │  │ MariaDB  │ │    │
│  │  │   Container  │  │  Container   │  │Container │ │    │
│  │  │              │  │              │  │          │ │    │
│  │  │  Port: 443   │  │  Port: 9000  │  │Port: 3306│ │    │
│  │  │  (TLS/SSL)   │  │  (PHP-FPM)   │  │  (MySQL) │ │    │
│  │  │              │  │              │  │          │ │    │
│  │  │  www-data    │  │  www-data    │  │  mysql   │ │    │
│  │  └──────┬───────┘  └──────┬───────┘  └────┬─────┘ │    │
│  │         │                 │                │       │    │
│  │         └─────────────────┴────────────────┘       │    │
│  │                           │                         │    │
│  └───────────────────────────┼─────────────────────────┘    │
│                              │                              │
│  ┌───────────────────────────┼─────────────────────────┐    │
│  │           Docker Volumes  │                         │    │
│  │                           │                         │    │
│  │  ┌────────────────────────▼──────────────────┐     │    │
│  │  │  /home/yimizare/data/wordpress/           │     │    │
│  │  │  (Shared: Nginx ↔ WordPress)              │     │    │
│  │  │  - WordPress core files                   │     │    │
│  │  │  - Themes, plugins, uploads               │     │    │
│  │  └───────────────────────────────────────────┘     │    │
│  │                                                     │    │
│  │  ┌─────────────────────────────────────────┐       │    │
│  │  │  /home/yimizare/data/mariadb/           │       │    │
│  │  │  (MariaDB only)                         │       │    │
│  │  │  - Database files                       │       │    │
│  │  └─────────────────────────────────────────┘       │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                              │
└─────────────────────────────────────────────────────────────┘

External Access: https://yimizare.42.fr (Port 443)
```

### 🔄 Request Flow

```
1. User Browser
   ↓
2. HTTPS Request (Port 443)
   ↓
3. Nginx Container
   ├─ SSL/TLS Termination
   ├─ Static Files → Serve directly
   └─ PHP Files → Forward to WordPress
      ↓
4. WordPress Container (PHP-FPM)
   ├─ Process PHP
   ├─ Query Database
   └─ Generate Response
      ↓
5. MariaDB Container
   ├─ Execute SQL
   └─ Return Data
      ↓
6. Response → Nginx → User Browser
```

---

## 🛠️ Technologies

| Component | Technology | Version |
|-----------|-----------|---------|
| **OS** | Debian | Bullseye |
| **Web Server** | Nginx | Latest |
| **Application** | WordPress | Latest |
| **Database** | MariaDB | 10.5+ |
| **PHP** | PHP-FPM | 7.4 |
| **Container** | Docker | 20.10+ |
| **Orchestration** | Docker Compose | 1.29+ |
| **SSL/TLS** | OpenSSL | 1.1+ |

---

## 📦 Prerequisites

### Required Software

```bash
# Docker
sudo apt-get update
sudo apt-get install -y docker.io

# Docker Compose
sudo apt-get install -y docker-compose

# Make
sudo apt-get install -y make

# Verify installations:
docker --version          # Docker version 20.10+
docker-compose --version  # docker-compose version 1.29+
make --version           # GNU Make 4.2+
```

---

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/inception.git
cd inception
```

### 2. Configure Environment

```bash
# Copy example .env file
cp srcs/.env.example srcs/.env

# Edit .env with your values
nano srcs/.env
```

**Required variables:**
```bash
DOMAIN_NAME=yimizare.42.fr
MYSQL_ROOT_PASSWORD=your_secure_password
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=your_db_password
WP_ADMIN_NAME=youradmin
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_MAIL=admin@example.com
WP_USER_NAME=regularuser
WP_USER_MAIL=user@example.com
WP_USER_PASSWORD=user_password
```

### 3. Configure Hosts File

```bash
# Add domain to /etc/hosts
sudo nano /etc/hosts

# Add this line:
127.0.0.1 login.42.fr
```

### 4. Create Data Directories

```bash
# Create volume directories
sudo mkdir -p /home/yimizare/data/wordpress
sudo mkdir -p /home/yimizare/data/mariadb

# Set permissions
sudo chown -R $USER:$USER /home/yimizare/data/
```

### 5. Build and Start

```bash
# Build and start all containers
make

# Or manually:
docker-compose -f srcs/docker-compose.yml up -d --build
```

---

## 💻 Usage

### Starting the Infrastructure

```bash
# Start all services
make up

# Or with docker-compose:
cd srcs
docker-compose up -d
```

### Stopping the Infrastructure

```bash
# Stop all services
make down

# Or with docker-compose:
cd srcs
docker-compose down
```

### Accessing Services

- **WordPress Site**: https://yimizare.42.fr
- **WordPress Admin**: https://yimizare.42.fr/wp-admin

### Default Credentials

- **Admin User**: As configured in .env (`WP_ADMIN_NAME`)
- **Regular User**: As configured in .env (`WP_USER_NAME`)

---

## 📁 Project Structure

```
inception/
├── Makefile                          # Build automation
├── README.md                         # This file
└── srcs/
    ├── .env                          # Environment variables (create from .env.example)
    ├── .env.example                  # Example environment file
    ├── docker-compose.yml            # Service orchestration
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile            # MariaDB image
        │   ├── conf/
        │   │   └── my.cnf            # MariaDB configuration
        │   └── tools/
        │       └── init_db.sh        # Database initialization
        ├── nginx/
        │   ├── Dockerfile            # Nginx image
        │   ├── conf/
        │   │   └── nginx.conf        # Nginx configuration
        │   └── tools/
        │       └── setup.sh          # SSL & startup script
        └── wordpress/
            ├── Dockerfile            # WordPress image
            ├── conf/
            │   └── www.conf          # PHP-FPM configuration
            └── tools/
                └── wpconfig.sh       # WordPress setup script
```

---

## ⚙️ Configuration

### Nginx Configuration

- **TLS Version**: 1.2 and 1.3 only
- **Port**: 443 (HTTPS only)
- **PHP Handler**: FastCGI to WordPress container
- **SSL Certificate**: Self-signed (auto-generated)

### WordPress Configuration

- **PHP Version**: 7.4
- **Process Manager**: PHP-FPM
- **Database**: MariaDB connection
- **Users**: 2 (Admin + Regular)

### MariaDB Configuration

- **Engine**: InnoDB
- **Charset**: utf8mb4
- **Collation**: utf8mb4_unicode_ci
- **Port**: 3306 (internal only)

---

## 🔒 Security

### Best Practices Implemented

✅ **No root processes** - All services run as non-root users  
✅ **TLS encryption** - HTTPS only, no HTTP  
✅ **Isolated networks** - Containers on dedicated network  
✅ **No hardcoded secrets** - All credentials in .env  
✅ **Minimal base images** - Debian Bullseye slim  
✅ **No unnecessary packages** - Security through minimalism  
✅ **Volume permissions** - Proper ownership (www-data, mysql)  

### Security Recommendations

- ⚠️ Change default passwords in production
- ⚠️ Use proper SSL certificates (not self-signed)
- ⚠️ Enable firewall rules
- ⚠️ Regular updates and patches
- ⚠️ Implement backup strategy

---

## 🧪 Testing

### Check Container Status

```bash
# View running containers
make ps

# Check logs
make logs

# Follow logs in real-time
make logs-follow
```

### Health Checks

```bash
# Nginx
docker exec nginx nginx -t

# PHP-FPM
docker exec wordpress php-fpm7.4 -t

# MariaDB
docker exec mariadb mysqladmin ping -h localhost
```

---

## 🐛 Troubleshooting

### Common Issues

#### Container Won't Start

```bash
# Check logs
docker logs <container_name>

# Rebuild
make re
```


## 📊 Makefile Commands

| Command | Description |
|---------|-------------|
| `make` | Build and start all containers |
| `make up` | Start all containers |
| `make down` | Stop all containers |
| `make stop` | Stop containers (keep them) |
| `make start` | Start existing containers |
| `make restart` | Restart all containers |
| `make build` | Build all images |
| `make rebuild` | Rebuild all images (no cache) |
| `make clean` | Stop and remove containers |
| `make fclean` | Complete cleanup (containers + volumes) |
| `make re` | Complete rebuild |
| `make ps` | Show container status |
| `make logs` | Show all logs |
| `make logs-follow` | Follow logs in real-time |

---

## 🤝 Contributing

This is a 42 School project and is not open for contributions. However, feel free to fork and adapt for your own learning!

---

## 📜 License

This project is part of the 42 School curriculum. All rights reserved.

---

## 👤 Author

**Yassine Imizare**

- GitHub: [@yourusername](https://github.com/yassineWoW)
- LinkedIn: [Your Name](https://linkedin.com/yassine-imizare-11aa95307/)

---

## 🙏 Acknowledgments

- **42 School** - For the incredible curriculum
- **Docker Community** - For excellent documentation



<div align="center">

**⭐ Star this repo if you found it helpful!**

Made with passion by a 1337 student

</div>
