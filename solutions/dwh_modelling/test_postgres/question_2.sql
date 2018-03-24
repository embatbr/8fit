SELECT
    E.channel,
    E.position
FROM (
    SELECT
        D.channel_name AS channel,
        dense_rank() OVER (ORDER BY C.amount DESC) AS position
    FROM (
        SELECT
            A.channel_sk,
            count(*) AS amount
        FROM
            dwh.user_first_install_fact A
        INNER JOIN
            client_dim B
            ON
                A.client_sk = B.client_sk
                AND B.os_name = 'android'
        GROUP BY
            A.channel_sk
    ) C
    INNER JOIN
        dwh.channel_dim D
        ON
            C.channel_sk = D.channel_sk
) E
WHERE
    E.position <= 5;
