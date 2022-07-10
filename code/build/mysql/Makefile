#================================
# Local MySQL Docker Configs
#================================
CONTAINER_NAME=demo-transactions-mysql
CONTAINER_VOLUME=demo-transactions-mysql-volume

CONTAINER_OUT_PORT=33070
CONTAINER_IN_PORT=3306

PASSWORD=123

DSN="demo:123@tcp(localhost:33070)/demo"

#===========================================
# команды makefile -
# если команда совпадет с названием каталога
#===========================================
.PHONY: help first-run start logs create-db sh mysql

help: Makefile
	@echo "Выберите опцию сборки:"
	@sed -n 's/^##//p' $< | column -s ':' |  sed -e 's/^/ /'

#===========================================
# RUN Локальные базы MySQL
#===========================================

## first-run: Развернуть контейнер локальной базы MySQL
first-run:
	docker run -d --name=$(CONTAINER_NAME) -e MYSQL_ROOT_PASSWORD=$(PASSWORD) -v $(CONTAINER_VOLUME):/var/lib/mysql -p $(CONTAINER_OUT_PORT):$(CONTAINER_IN_PORT) mysql

## create-db: создать бд
create-db:
	docker cp create-db.sql $(CONTAINER_NAME):create-db.sql && \
	docker cp db.sql $(CONTAINER_NAME):db.sql && \
	docker exec $(CONTAINER_NAME) bash -l -c "mysql -uroot -p$(PASSWORD) < create-db.sql" && \
	docker exec $(CONTAINER_NAME) bash -l -c "mysql -uroot -p$(PASSWORD) demo < db.sql"

## start: Запустить контейнер локальной базы MySQL
start:
	docker start $(CONTAINER_NAME)

## logs: посмотреть логи локальной базы MySQL
logs:
	docker logs -f $(CONTAINER_NAME)

## sh: Shell
sh:
	docker exec -it $(CONTAINER_NAME) bash

## mysql: Работаем в psql локальной базы MySQL
mysql:
	docker exec -it $(CONTAINER_NAME) mysql -uroot -p$(PASSWORD)
