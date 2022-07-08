Уровни Изоляции Транзакций в PostgreSQL
=======================================

.. _Официальный сайт PostgreSQL: https://www.postgresql.org/
.. _PostgreSQL Docker образ: https://hub.docker.com/_/postgres

`Официальный сайт PostgreSQL`_, `PostgreSQL Docker образ`_.

Как это вообще делается

.. code-block:: bash
  :linenos:

      $ docker pull postgres
      $ docker run --name demo-transactions-postgres -e POSTGRES_PASSWORD=123 -d postgres

.. image:: ../../img/postgresql/001-docker-pull-postgres.png
  :width: 1188
  :alt: docker pull postgresql

.. image:: ../../img/postgresql/002-run-postgresql-container.png
  :width: 1689
  :alt: run postgresql container

.. image:: ../../img/postgresql/003-view-postgresql-container-in-docker-desktop.png
  :width: 1601
  :alt: view postgresql container in docker desktop

Но я написал удобный Makefile см /code/build/mysql/Makefile