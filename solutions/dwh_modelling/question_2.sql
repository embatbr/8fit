-- Question: Write a query, using Redshift ANSI SQL, to know which are the top 5 channels
-- with the most installs coming in from Android.

-- Observation: "most installs" or "most FIRST installs"? I am assuming the "first" was
-- forgotten.


-- Channels with the same amount must appear in the same position.
-- If two channels have rank 5 and the others ranks have just 1 channel (returning
-- 6 channels), both must appear, not one be cut by chance. Therefore, windowing.

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
