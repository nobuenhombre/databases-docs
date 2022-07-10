Подготовка базы demo MySQL
==========================

.. _Официальный сайт MySQL: https://www.mysql.com/
.. _MySQL Docker образ: https://hub.docker.com/_/mysql

`Официальный сайт MySQL`_, `MySQL Docker образ`_.

Как это вообще делается

.. code-block:: bash
  :linenos:

      $ docker pull mysql
      $ docker run --name=demo-transactions-mysql -e MYSQL_ROOT_PASSWORD=123 -d mysql

.. image:: ../../img/mysql/001-docker-pull-mysql.png
  :width: 1188
  :alt: docker pull mysql

.. image:: ../../img/mysql/002-run-mysql-container.png
  :width: 1689
  :alt: run mysql container

.. image:: ../../img/mysql/003-view-mysql-container-in-docker-desktop.png
  :width: 1601
  :alt: view mysql container in docker desktop

Но я написал удобный Makefile см /code/build/mysql/Makefile

Нужно будет выполнить ``make first-run`` и читать лог в Docker Desktop что-бы дождаться когда
сервер БД успешно запустится. для MySQL это занимает 10-15 секунд на моем ноутбуке.
Затем выполнить ``make create-db``

.. code-block:: bash
  :linenos:

      $ make first-run
      $ make create-db

После этого я настроил подключение к базе в IDE, вот что получилось:

.. image:: ../../img/created-databases-in-ide.png
  :width: 1601
  :alt: created databases in ide