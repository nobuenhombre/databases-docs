#================================
# Local MySQL Docker Configs
#================================
CONTAINER_NAME=demo-transactions-mysql
CONTAINER_VOLUME=demo-transactions-mysql-volume

CONTAINER_OUT_PORT=33070
CONTAINER_IN_PORT=3306

PASSWORD=123

DSN="demo:123@tcp(localhost:33070)/demo"

#=========================================================================================
# Execute after First Start
#=========================================================================================
# CREATE USER 'demo'@'localhost' IDENTIFIED BY '123';
# CREATE DATABASE demo;
# GRANT ALL PRIVILEGES ON demo.* TO 'demo'@'localhost';
# FLUSH PRIVILEGES;
# quit;

#===========================================
# команды makefile -
# если команда совпадет с названием каталога
#===========================================
.PHONY: help deps swagen run build all lint test fmt

help: Makefile
	@echo "Выберите опцию сборки:"
	@sed -n 's/^##//p' $< | column -s ':' |  sed -e 's/^/ /'

#===========================================
# RUN Локальные базы MySQL
#===========================================

## run: Развернуть контейнер локальной базы MySQL
run:
	docker run -d --name=$(CONTAINER_NAME) -e MYSQL_ROOT_PASSWORD=$(PASSWORD) -v $(CONTAINER_VOLUME):/var/lib/mysql -p $(CONTAINER_OUT_PORT):$(CONTAINER_IN_PORT) mysql

## start: Запустить контейнер локальной базы MySQL
start:
	docker start $(CONTAINER_NAME)

## logs: посмотреть логи локальной базы MySQL
logs:
	docker logs -f $(CONTAINER_NAME)

## mysql: Работаем в psql локальной базы MySQL
mysql:
	docker exec -it $(CONTAINER_NAME) mysql -uroot -p$(PASSWORD)
