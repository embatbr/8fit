-- Solution 1:

SELECT
    DISTINCT yesterday_installs.user_id
FROM (
    SELECT
        user_id,
        client_sk,
        count(*) AS amount
    FROM
        dwh.user_first_install_fact
    WHERE
        date_trunc('day', now()) - date_trunc('day', installed_at) = '1 day'
    GROUP BY
        user_id,
        client_sk
) yesterday_installs
WHERE
    yesterday_installs.amount > 1;


-- Solution 2:

SELECT
    DISTINCT yesterday_installs_dup.user_id
FROM (
    SELECT
        user_id,
        client_sk
    FROM
        dwh.user_first_install_fact
    WHERE
        date_trunc('day', now()) - date_trunc('day', installed_at) = '1 day'
    GROUP BY
        user_id,
        client_sk
        HAVING
            count(*) > 1
) yesterday_installs_dup;
