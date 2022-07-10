#================================
# Local Postgres Docker Configs
#================================
CONTAINER_NAME=demo-transactions-postgres
CONTAINER_VOLUME=demo-transactions-postgres-volume

CONTAINER_OUT_PORT=54370
CONTAINER_IN_PORT=5432

PASSWORD=123

DSN="postgres://demo:123@localhost:54370/demo?sslmode=disable"

#===========================================
# команды makefile -
# если команда совпадет с названием каталога
#===========================================
.PHONY: help first-run start logs create-db sh psql

help: Makefile
	@echo "Выберите опцию сборки:"
	@sed -n 's/^##//p' $< | column -s ':' |  sed -e 's/^/ /'

#===========================================
# RUN Локальные базы Postgres
#===========================================

## first-run: Развернуть контейнер локальной базы Postgres
first-run:
	docker run -d --name $(CONTAINER_NAME) -e POSTGRES_PASSWORD=$(PASSWORD) -v $(CONTAINER_VOLUME):/var/lib/postgresql/data -p $(CONTAINER_OUT_PORT):$(CONTAINER_IN_PORT) postgres

## create-db: создать бд
create-db:
	docker cp create-db.sql $(CONTAINER_NAME):create-db.sql && \
	docker exec $(CONTAINER_NAME) bash -l -c "psql -U postgres < create-db.sql"

## start: Запустить контейнер локальной базы Postgres
start:
	docker start $(CONTAINER_NAME)

## logs: посмотреть логи локальной базы Postgres
logs:
	docker logs -f $(CONTAINER_NAME)

## sh: Shell
sh:
	docker exec -it $(CONTAINER_NAME) bash

## psql: Работаем в psql локальной базы Postgres
psql:
	docker exec -it $(CONTAINER_NAME) psql -U postgres
