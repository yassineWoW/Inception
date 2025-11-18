DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml

all: build up

build:
	@echo "🔨 Building Inception project..."
	@mkdir -p /home/yimizare/data/mariadb
	@mkdir -p /home/yimizare/data/wordpress
	@$(DOCKER_COMPOSE) build

build-no-cache:
	@echo "🔨 Building Inception project (no cache)..."
	@mkdir -p /home/yimizare/data/mariadb
	@mkdir -p /home/yimizare/data/wordpress
	@$(DOCKER_COMPOSE) build --no-cache

# Build individual services
build-nginx:
	@echo "🔨 Building Nginx..."
	@$(DOCKER_COMPOSE) build --no-cache nginx

build-wordpress:
	@echo "🔨 Building WordPress..."
	@$(DOCKER_COMPOSE) build --no-cache wordpress

build-mariadb:
	@echo "🔨 Building MariaDB..."
	@$(DOCKER_COMPOSE) build --no-cache mariadb

up:
	@echo "🚀 Starting Inception project..."
	@$(DOCKER_COMPOSE) up -d

down:
	@echo "🛑 Stopping Inception project..."
	@$(DOCKER_COMPOSE) down

clean: down
	@echo "🧹 Cleaning Docker resources..."
	@docker system prune -af

fclean: clean
	@echo "🗑️  Removing all Inception project data..."
	@sudo rm -rf /home/yimizare/data/mariadb/*
	@sudo rm -rf /home/yimizare/data/wordpress/*
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean all

logs:
	@$(DOCKER_COMPOSE) logs -f

status:
	@echo "📊 Container Status:"
	@docker ps -a --filter "name=nginx" --filter "name=wordpress" --filter "name=mariadb"

# Database shortcuts
db-shell:
	@echo "🗄️  Accessing MariaDB shell..."
	@docker exec -it mariadb bash -c 'mysql -u$${MYSQL_USER} -p$${MYSQL_PASSWORD} $${MYSQL_DATABASE}'

db-root:
	@echo "🔑 Accessing MariaDB as root..."
	@docker exec -it mariadb bash -c 'mysql -uroot -p$${MYSQL_ROOT_PASSWORD}'

db-show:
	@echo "📊 Databases:"
	@docker exec -it mariadb bash -c 'mysql -uroot -p$${MYSQL_ROOT_PASSWORD} -e "SHOW DATABASES;"'

db-tables:
	@echo "📋 Tables:"
	@docker exec -it mariadb bash -c 'mysql -u$${MYSQL_USER} -p$${MYSQL_PASSWORD} $${MYSQL_DATABASE} -e "SHOW TABLES;"'

.PHONY: all build build-no-cache build-nginx build-wordpress build-mariadb \
        up down clean fclean re logs status \
        db-shell db-root db-show db-tables




#DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml

#all: build up 

#build_no_cache:
#	@echo "Building Inception project..."
#	@mkdir -p /home/yimizare/data/mariadb
#	@mkdir -p /home/yimizare/data/wordpress
#	@$(DOCKER_COMPOSE) build --no-cache

#build:
#	@echo "Building Inception project..."
#	@mkdir -p /home/yimizare/data/mariadb
#	@mkdir -p /home/yimizare/data/wordpress
#	@$(DOCKER_COMPOSE) build

#up:
#	@$(DOCKER_COMPOSE) up -d

#down:
#	@$(DOCKER_COMPOSE) down

#clean:
#	@echo "Cleaning Containers..."
#	@$(DOCKER_COMPOSE) down -v
#	@docker system prune -af

#fclean: clean
#	@echo "Removing all Inception project files..."
#	@sudo rm -rf /home/yimizare/data/mariadb/*
#	@sudo rm -rf /home/yimizare/data/wordpress/*

#re: fclean all
#	@echo "Rebuilding Inception project..."

#.PHONY: all build up down clean fclean re



