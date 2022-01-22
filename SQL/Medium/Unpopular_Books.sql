/*
        Table: Books

        +----------------+---------+
        | Column Name    | Type    |
        +----------------+---------+
        | book_id        | int     |
        | name           | varchar |
        | available_from | date    |
        +----------------+---------+
        book_id is the primary key of this table.
        

        Table: Orders

        +----------------+---------+
        | Column Name    | Type    |
        +----------------+---------+
        | order_id       | int     |
        | book_id        | int     |
        | quantity       | int     |
        | dispatch_date  | date    |
        +----------------+---------+
        order_id is the primary key of this table.
        book_id is a foreign key to the Books table.
        

        Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than one month from today. Assume today is 2019-06-23.

        Return the result table in any order.

        The query result format is in the following example.

        

        Example 1:

        Input: 
        Books table:
        +---------+--------------------+----------------+
        | book_id | name               | available_from |
        +---------+--------------------+----------------+
        | 1       | "Kalila And Demna" | 2010-01-01     |
        | 2       | "28 Letters"       | 2012-05-12     |
        | 3       | "The Hobbit"       | 2019-06-10     |
        | 4       | "13 Reasons Why"   | 2019-06-01     |
        | 5       | "The Hunger Games" | 2008-09-21     |
        +---------+--------------------+----------------+
        Orders table:
        +----------+---------+----------+---------------+
        | order_id | book_id | quantity | dispatch_date |
        +----------+---------+----------+---------------+
        | 1        | 1       | 2        | 2018-07-26    |
        | 2        | 1       | 1        | 2018-11-05    |
        | 3        | 3       | 8        | 2019-06-11    |
        | 4        | 4       | 6        | 2019-06-05    |
        | 5        | 4       | 5        | 2019-06-20    |
        | 6        | 5       | 9        | 2009-02-02    |
        | 7        | 5       | 8        | 2010-04-13    |
        +----------+---------+----------+---------------+
        Output: 
        +-----------+--------------------+
        | book_id   | name               |
        +-----------+--------------------+
        | 1         | "Kalila And Demna" |
        | 2         | "28 Letters"       |
        | 5         | "The Hunger Games" |
        +-----------+--------------------+
*/
SELECT 
        books.book_id, 
        books.name
FROM books
LEFT JOIN
(
        SELECT
                SUM(quantity) AS q,
                book_id
        FROM
                orders
        WHERE dispatch_date BETWEEN DATE( '2019-06-23' - INTERVAL 1 YEAR ) AND DATE('2019-06-23')
        GROUP BY book_id
) AS orders ON books.book_id = orders.book_id

WHERE datediff('2019-06-23', books.available_from) > 30 
AND COALESCE(q, 0) < 10

GROUP BY 
        books.book_id, 
        books.name