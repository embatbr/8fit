-- Question: Write a query, using Redshift ANSI SQL, to know which are the top 5 channels
-- with the most installs coming in from Android.

-- Observation: "most installs" or "most FIRST installs"? I am assuming the "first" was
-- forgotten.


-- Channels with the same amount must appear in the same position.
-- If two channels have rank 5 and the others ranks have just 1 channel (returning
-- 6 channels), both must appear, not one be cut by chance. Therefore, windowing.

WITH channel_for_android_install AS (
    SELECT
        u.channel_sk AS channel,
        count(*) AS amount
    FROM
        dwh.user_first_install_fact
    INNER JOIN
        client_dim c
        ON
            u.client_sk = c.client_sk
            AND c.os_name = 'Android'
    GROUP BY
        u.channel
)
SELECT
    w.channel
FROM
    channel_for_android_install w
WHERE
    dense_rank() OVER (PARTITION BY w.channel ORDER BY w.amount DESC) <= 5;
