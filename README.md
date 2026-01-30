# Docker Dev Station - Complete Development Environment

![Docker Dev Station Architecture](./resources/Archi_Environnement_DEV.svg)

## 🚀 Overview

**Docker Dev Station** is a comprehensive, modular development environment that provides all the tools and services needed for modern application development, testing, and deployment. Built on Docker, it offers a consistent, isolated environment that can be easily managed and customized.

## 📁 Project Structure

```
.
├── environnement/          # Core Docker Dev Station
│   ├── admin/              # Administration tools (Portainer)
│   ├── apm/               # Application Performance Monitoring
│   ├── db/                # Database servers (MariaDB, MySQL, PostgreSQL, MongoDB, Oracle)
│   ├── dxp/               # Digital Experience Platforms (Liferay, Drupal, Strapi)
│   ├── iam/               # Identity & Access Management (Keycloak, LDAP)
│   ├── language/          # Language environments (Java)
│   ├── mail/              # Mail servers (Fake SMTP, Mockmock)
│   ├── monitoring/        # Monitoring tools (Glowroot, Glances)
│   ├── proxy/             # Proxy servers (Squid, Simple Proxy)
│   ├── reverse-proxy/     # Reverse proxies (Traefik, Apache, Kong)
│   ├── saas/              # SaaS tools (n8n)
│   ├── scripts/           # Utility scripts
│   ├── sharing/           # File sharing tools
│   ├── sonar/             # Code quality (SonarQube)
│   ├── storage/           # Storage solutions (Minio S3)
│   ├── tools/             # Development tools (VSCode, Mermaid)
│   └── ui/                # User interface components
├── resources/            # Architecture diagrams and documentation
├── sources/              # Sample projects and source code
└── README.md              # This file
```

## 🎯 Key Features

- **Modular Architecture**: 23+ independent services that can be started/stopped individually
- **Centralized Management**: Unified command interface via `dcmd.sh`
- **Production-Ready Configurations**: Optimized Docker configurations for each service
- **Development Tools**: Everything from IDEs to debugging tools
- **Database Support**: Multiple SQL and NoSQL databases
- **Monitoring & APM**: Performance monitoring and application insights
- **Network Infrastructure**: Reverse proxies, load balancers, and network tools

## 🚀 Getting Started

### Prerequisites

- Docker installed and running
- Docker Compose v3+ 
- Basic familiarity with Docker concepts

### Setup

1. **Create the development network**:
   ```bash
   ./createNetwork.sh
   ```

2. **Configure environment variables**:
   ```bash
   cp env_template .env
   # Edit .env to set your source code directory
   ```

3. **Add convenient aliases to your `.bashrc`**:
   ```bash
   echo "alias dds='cd $(pwd)'" >> ~/.bashrc
   echo "alias ecmd='$(pwd)/environnement/ecmd.sh'" >> ~/.bashrc
   source ~/.bashrc
   ```

## 📖 Service Categories

### 🔧 Administration & Management

- **Portainer**: Web-based Docker management UI (port 9999)
- **OmniDB**: Database management interface (port 8000)
- **Centralized scripts**: `dcmd.sh` for unified service management

### 🗃️ Database Servers

| Service | Port | Description |
|---------|------|-------------|
| MariaDB | 3306 | MySQL-compatible relational database |
| MySQL | 3306 | Oracle MySQL database |
| PostgreSQL | 5432 | Advanced open-source database |
| MongoDB | 27017 | NoSQL document database |
| Oracle | 1521 | Enterprise relational database |

### 🌐 Digital Experience Platforms

- **Liferay DXP**: Enterprise portal platform (port 18080)
- **Drupal**: PHP-based CMS
- **Strapi**: Headless CMS with REST/GraphQL APIs

### 🔐 Identity & Access Management

- **Keycloak**: Open-source identity and access management (port 9080)
- **LDAP**: Directory services
- **LDAP Admin**: Web interface for LDAP management

### 🛠️ Development Tools

- **VSCode Server**: Web-based IDE (port 13219)
- **Java Environment**: Pre-configured Java development container
- **Ionic Framework**: Mobile app development environment
- **Mermaid**: Diagram generation tool

### 📊 Monitoring & APM

- **Glowroot**: Java application performance monitoring (port 4000)
- **Glances**: System monitoring dashboard
- **Health Checks**: Container health monitoring

### 🔄 Network & Proxy

- **Traefik**: Modern reverse proxy and load balancer
- **Apache**: Web server and reverse proxy
- **Kong**: API gateway and management layer
- **Squid**: Caching proxy server

### ✉️ Mail Services

- **Fake SMTP**: Test mail server
- **Mockmock**: Mock SMTP server for development

### 💾 Storage Solutions

- **Minio**: S3-compatible object storage

### 🔍 Code Quality

- **SonarQube**: Continuous code quality inspection

### ⚙️ Automation & Workflow

- **n8n**: Workflow automation tool
- **Stirling-PDF**: PDF management tool

## 🎬 Common Commands

### Service Management

```bash
# Start a service
./dcmd.sh <service_name>

# Stop a service
./dcmd.sh <service_name> down

# Clean a service (remove containers, volumes, images)
./dcmd.sh <service_name> clean

# View logs
./dcmd.sh <service_name> logs

# Access container shell
./dcmd.sh <service_name> shell

# Access container as root
./dcmd.sh <service_name> shellr
```

### Specific Service Examples

```bash
# Start MariaDB database
./dcmd.sh mariadb

# Start Liferay portal
./dcmd.sh liferay

# Start VSCode IDE
./dcmd.sh vscode

# Start Keycloak authentication server
./dcmd.sh keycloak

# Start SonarQube for code analysis
./dcmd.sh sonar

# Start Portainer for Docker management
./dcmd.sh admin
```

## 🔧 Configuration Details

### Network

All services use a common Docker network named `devnet`:
```bash
# Create the network (if not already created)
docker network create devnet
```

### Service Configuration

Each service has:
- `docker-compose.yml`: Docker configuration
- `ecmd-meta.json`: Service metadata (name, description, port, etc.)
- Startup scripts: `start*.sh` for easy launching

### Example: MariaDB Configuration

```yaml
# environnement/db/mariadb/mariadb-compose.yml
version: '3.8'

services:
  mariadb:
    image: mariadb:11.8.2
    container_name: dds-mariadb
    environment:
      MYSQL_ROOT_PASSWORD: mdproot
      MYSQL_DATABASE: ha_db
      MYSQL_USER: user
      MYSQL_PASSWORD: mdpuser
    ports:
      - "3306:3306"
    volumes:
      - mariadb_data:/var/lib/mysql
    networks:
      - devnet
```

## 💡 Usage Tips

### Java Development

```bash
# Start Java environment
./ecmd.sh startjc

# Enter Java container
./ecmd.sh injc
```

### Ionic Development

```bash
# Set up Ionic environment
source ./setEnv.sh ionic
./scripts/shell.sh

# Install Android dependencies (once)
/home/user1/script/installAndroid.sh

# Start Ionic application
ionic serve --lab --address=0.0.0.0
```

### Database Management

```bash
# Start database admin interface
./ecmd.sh dbadmin
# Access at http://localhost:8000
```

### Code Quality Analysis

```bash
# Start SonarQube server
./ecmd.sh sonar
# Remove sonarHTML plugin from admin interface
```

## 🔍 Monitoring & Debugging

### Docker Commands

```bash
# List all containers
docker ps -a

# List volumes
docker volume ls

# Remove container/image
docker rm <container_id>
docker rmi <image_id>

# Copy files from container
docker cp <containerId>:/file/path /host/path

# Network diagnostics
netstat -an
```

### Java Specific

```bash
# Switch Java version in container
sudo update-alternatives --config java
```

## 📈 Architecture Highlights

1. **Modular Design**: Each service is independent but can communicate via `devnet`
2. **Persistent Storage**: All services use Docker volumes for data persistence
3. **Unified Management**: Centralized command interface via `dcmd.sh`
4. **Production-Ready**: Configurations optimized for development and testing
5. **Extensible**: Easy to add new services following the established pattern

## 🎯 Best Practices

1. **Start only what you need**: Activate services as required
2. **Use the centralized commands**: `dcmd.sh` provides consistent interface
3. **Monitor resource usage**: Some services (like Liferay) require significant memory
4. **Backup important data**: Especially database volumes
5. **Clean up regularly**: Use `clean` command to remove unused resources

## 🔗 Additional Resources

- **Official Documentation**: Check each service's official documentation
- **Docker Documentation**: https://docs.docker.com/
- **Service-Specific Guides**: In each service directory

## 📝 Notes

- The architecture schema (`resources/Archi_Environnement_DEV.svg`) provides a visual overview
- Service ports are documented in each service's `ecmd-meta.json` file
- Some services have specific requirements (e.g., Liferay needs 4GB+ RAM)
- The environment is designed for development/testing, not production use

## 🚀 Quick Start Checklist

1. [ ] Create `devnet` Docker network
2. [ ] Configure `.env` file with your paths
3. [ ] Add aliases to your shell configuration
4. [ ] Start required services with `dcmd.sh`
5. [ ] Access services via documented ports
6. [ ] Explore additional services as needed

Enjoy your Docker Dev Station! 🎉