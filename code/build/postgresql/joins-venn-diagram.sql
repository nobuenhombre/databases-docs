-- Left Join
SELECT w.*, l.name AS lang
FROM Words AS w
         LEFT JOIN Languages AS l
                   ON w.lang_id = l.id;


-- Right Join
SELECT w.*, l.name AS lang
FROM Words AS w
         RIGHT JOIN Languages AS l
                    ON w.lang_id = l.id;


-- Inner Join
SELECT w.*, l.name AS lang
FROM Words AS w
         INNER JOIN Languages AS l
                    ON w.lang_id = l.id;

-- Cross Join
SELECT w.*, l.name AS lang
FROM Words AS w
         CROSS JOIN Languages AS l;


-- Left Excluding Join
SELECT w.*, l.name AS lang
FROM Words AS w
         LEFT JOIN Languages AS l
                   ON w.lang_id = l.id
WHERE l.name IS NULL;


-- Right Excluding Join
SELECT w.*, l.name AS lang
FROM Words AS w
         RIGHT JOIN Languages AS l
                    ON w.lang_id = l.id
WHERE w.name IS NULL;


-- Full Outer Join
SELECT w.*, l.name AS lang
FROM Words AS w
         FULL OUTER JOIN Languages AS l
                         ON w.lang_id = l.id;


-- Outer Excluding Join
SELECT w.*, l.name AS lang
FROM Words AS w
         FULL OUTER JOIN Languages AS l
                         ON w.lang_id = l.id
WHERE
    w.name IS NULL OR l.name IS NULL;