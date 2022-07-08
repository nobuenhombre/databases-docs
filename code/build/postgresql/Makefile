#================================
# Local Postgres Docker Configs
#================================
CONTAINER_NAME=demo-transactions-postgres
CONTAINER_VOLUME=demo-transactions-postgres-volume

CONTAINER_OUT_PORT=54370
CONTAINER_IN_PORT=5432

PASSWORD=123

DSN="postgres://demo:123@localhost:54370/demo?sslmode=disable"

#=========================================================================================
# Execute after First Start
#=========================================================================================
# CREATE USER demo;
# CREATE DATABASE demo;
# GRANT ALL PRIVILEGES ON DATABASE demo TO demo;
# \password demo
# \q

#===========================================
# команды makefile -
# если команда совпадет с названием каталога
#===========================================
.PHONY: help deps swagen run build all lint test fmt

help: Makefile
	@echo "Выберите опцию сборки:"
	@sed -n 's/^##//p' $< | column -s ':' |  sed -e 's/^/ /'

#===========================================
# RUN Локальные базы Postgres
#===========================================

## run: Развернуть контейнер локальной базы Postgres
run:
	docker run -d --name $(CONTAINER_NAME) -e POSTGRES_PASSWORD=$(PASSWORD) -v $(CONTAINER_VOLUME):/var/lib/postgresql/data -p $(CONTAINER_OUT_PORT):$(CONTAINER_IN_PORT) postgres

## start: Запустить контейнер локальной базы Postgres
start:
	docker start $(CONTAINER_NAME)

## logs: посмотреть логи локальной базы Postgres
logs:
	docker logs -f $(CONTAINER_NAME)

## psql: Работаем в psql локальной базы Postgres
psql:
	docker exec -it $(CONTAINER_NAME) psql -U postgres
