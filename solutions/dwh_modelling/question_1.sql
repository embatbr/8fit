-- Question: Write a query, using Redshift ANSI SQL, to find which user_id has
-- duplicated installs (more than one install) for yesterday.


-- Assuming the table "dwh.user_first_install_fact" has a fictional key composed
-- of (user_id, device_id, client_sk), whenever these 3 columns appear repeated, the
-- "user 1st install" is repeated in a device. This seems as an impossibility.

-- However, if an user installs the same client in two similar devices (e.g., two similar iPhones),
-- is the device_id different? Since "device" is the unique piece of hardware, two similar iPhones,
-- of the same version and manufactured together (twins) are different devices. They could be similar
-- if we're using a dimension table "device_type", but the field is a raw fact.

-- That said, the "devide_id" is the unique ID for each device in the world.

-- If the client installs, removes and installs again (always in the same device),
-- there are at least two installations, but the table "dwh.user_first_install_fact"
-- receives only 1 record. Therefore, the field "device_id" is not relevant in this case.

-- I am assuming the field "date_sk" references a table "date_dim" containing year, month and day,
-- and with values matching the year, month and day extracted from field "installed_at". While
-- "installed_at" is almost unique, for some analyses the table "date_dim" is preferable. Here, I
-- will rely on Redshift datetime functions, instead of creating an UDF to determine when a date
-- "is yesterday" or use a table that wasn't provided.


-- Solution 1:

SELECT
    yesterday_installs.user_id
FROM (
    SELECT
        user_id,
        client_sk,
        count(*) AS amount
    FROM
        dwh.user_first_install_fact
    WHERE
        datediff(day, trunc(installed_at), CURRENT_DATE) = 1
    GROUP BY
        user_id,
        client_sk
) yesterday_installs
WHERE
    yesterday_installs.amount > 1;


-- Solution 2:

SELECT
    yesterday_installs_dup.user_id
FROM (
    SELECT
        user_id,
        client_sk
    FROM
        dwh.user_first_install_fact
    WHERE
        datediff(day, trunc(installed_at), CURRENT_DATE) = 1
    GROUP BY
        user_id,
        client_sk
        HAVING
            count(*) > 1
) yesterday_installs_dup;
