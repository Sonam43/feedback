# Docker Deployment Guide

## Prerequisites

- Docker Desktop installed ([download](https://www.docker.com/products/docker-desktop))
- Docker Compose (included with Docker Desktop)

## Local Development with Docker

### 1. Build and Run

```bash
# Build images and start services
docker-compose up --build

# Or run in background
docker-compose up -d --build
```

### 2. Access Application

- App: http://localhost:5000
- PostgreSQL: localhost:5432

### 3. Stop Services

```bash
docker-compose down

# Also remove volumes (database data)
docker-compose down -v
```

## Docker Commands

```bash
# View running containers
docker-compose ps

# View logs
docker-compose logs -f app
docker-compose logs -f db

# Access database
docker-compose exec db psql -U postgres -d college_management

# Restart service
docker-compose restart app
docker-compose restart db

# Remove everything
docker-compose down -v
```

## Environment Variables in Docker

Edit `.env` file for Docker variables:

```env
NODE_ENV=development
DB_HOST=db
DB_PORT=5432
DB_NAME=college_management
DB_USER=postgres
DB_PASSWORD=postgres
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_app_password
SESSION_SECRET=your_secret_key
```

## Building Docker Image for Production

```bash
# Build image
docker build -t college-management:latest .

# Run container
docker run -d \
  --name college-management \
  -p 5000:3000 \
  -e DB_HOST=your_db_host \
  -e DB_PASSWORD=your_password \
  college-management:latest

# Push to Docker Hub (optional)
docker tag college-management:latest your_username/college-management:latest
docker push your_username/college-management:latest
```

## Troubleshooting

### Container won't start
```bash
# Check logs
docker-compose logs app
```

### Database connection error
```bash
# Ensure db service is running
docker-compose logs db

# Restart database
docker-compose restart db
```

### Port already in use
```bash
# Change port in docker-compose.yml
# Change "5000:3000" to "5001:3000"
```

## Deploy to Docker Hub

1. Create Docker Hub account: https://hub.docker.com
2. Login: `docker login`
3. Tag image: `docker tag college-management YOUR_USERNAME/college-management`
4. Push: `docker push YOUR_USERNAME/college-management`

---

See also: [DEPLOYMENT.md](./DEPLOYMENT.md)
