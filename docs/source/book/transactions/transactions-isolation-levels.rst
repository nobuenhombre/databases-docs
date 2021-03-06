Уровни Изоляции Транзакций
==========================

При работе с **database transactions**,
одной важной вещью, которую мы должны сделать,
является выбор подходящего **isolation level** для нашего приложения.
Хотя существует четко определенный стандарт,
каждое ядро базы данных может реализовывать его по-своему
и, следовательно, может вести себя по-разному в каждом **isolation level**.

ACID
----

Как мы уже узнали из предыдущей лекции,
транзакция базы данных должна удовлетворять ACID свойству,
обозначающему Atomicity, Consistency, Isolation, и Durability.

Isolation
~~~~~~~~~

является одним из четырех свойств транзакции базы данных,
где на самом высоком уровне идеальная изоляция гарантирует,
что все параллельные транзакции не будут влиять друг на друга.

Существует несколько способов вмешательства в транзакцию других транзакций,
выполняющихся одновременно с ней.
Это вмешательство вызовет то, что мы назвали **read phenomenon**.

4 Read Phenomenon
~~~~~~~~~~~~~~~~~

Вот некоторые феномены чтения, которые могут возникнуть,
если база данных работает на низком уровне изоляции транзакций:

#. **dirty read**
    Это происходит, когда транзакция читает данные,
    записанные другой параллельной транзакцией,
    которая еще не была зафиксирована.
    Это ужасно плохо, потому что мы не знаем,
    будет ли эта другая транзакция в конечном итоге зафиксирована или отменена.
    Таким образом, мы можем в конечном итоге использовать неверные данные в случае отката.

#. **non-repeatable read**
    Когда транзакция дважды читает одну и ту же запись и видит разные значения,
    потому что строка была изменена другой транзакцией,
    которая была зафиксирована после первого чтения.

#. **phantom read**
    похожее явление, но влияет на запросы, которые ищут несколько строк вместо одной.
    В этом случае тот же запрос выполняется повторно,
    но возвращается другой набор строк из-за некоторых изменений,
    сделанных другими недавно подтвержденными транзакциями,
    таких как вставка новых строк или удаление существующих строк,
    которые удовлетворяют условию поиска запроса текущей транзакции.

#. **serialization anomaly**
    Еще одно явление, связанное с выделением группы транзакций.
    Это когда результат группы одновременно совершенных транзакций не может быть достигнут,
    если мы попытаемся запустить их последовательно в любом порядке, не перекрывая друг друга.

4 уровня изоляции
-----------------

Чтобы справиться с этими явлениями, Американским национальным институтом стандартов
или ANSI были определены 4 стандартных уровня изоляции.

#. **read uncommitted**
    Самый низкий уровень изоляции.
    Транзакции на этом уровне могут видеть данные,
    записанные другими незафиксированными транзакциями,
    что позволяет произойти **dirty read** явлению.

#. **read committed**
    Следующий уровень изоляции,
    когда транзакции могут видеть только те данные,
    которые были зафиксированы другими транзакциями.
    Из-за этого **dirty read** уже не возникает.

#. **repeatable read**
    Этот уровень изоляции является чуть более строгим.
    Он гарантирует, что один и тот же запрос на выборку
    всегда будет возвращать один и тот же результат,
    независимо от того, сколько раз он выполняется,
    даже если некоторые другие параллельные транзакции зафиксировали новые изменения,
    удовлетворяющие запросу.

#. **serializable**
    Наконец, самый высокий уровень изоляции.
    Параллельные транзакции, выполняемые на этом уровне,
    гарантированно могут дать тот же результат,
    как если бы они выполнялись последовательно в некотором порядке,
    одна за другой, без перекрытия.
    Таким образом, в основном это означает,
    что существует по крайней мере 1 способ упорядочить эти параллельные транзакции,
    так что если мы запустим их одну за другой,
    конечный результат будет одинаковым.

Связь между уровнями изоляции и явлениями чтения
================================================

Хорошо, теперь пришло время найти связь
между уровнями изоляции и явлениями чтения.
Мы запустим несколько транзакций с разными уровнями изоляции
в MySQL и Postgres,

.. toctree::
   :maxdepth: 5
   :caption: Содержание:

   prepare-demo-db-mysql.rst
   prepare-demo-db-postgresql.rst
   transactions-isolation-levels-mysql.rst
   transactions-isolation-levels-postgresql.rst


Чтобы выяснить, какие явления возможны на каждом уровне.
Затем мы заполним эту информацию в сводной таблице.



