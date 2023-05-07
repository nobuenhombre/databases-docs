UPDATE
    users
SET
    full_name = data.name,
    email = data.email
    FROM
    (VALUES
         ('two', 'Natan', 'natan@batan.net'),
         ('three', 'Nostra', 'nostra@caliostra.org'),
         ('sum', 'Zorg', 'zorg@janbatist.io')
    ) AS data (id, name, email)
WHERE
    users.username = data.id;