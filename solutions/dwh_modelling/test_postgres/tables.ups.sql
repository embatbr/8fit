CREATE SCHEMA dwh;


CREATE TABLE IF NOT EXISTS dwh.user_first_install_fact (
    user_id VARCHAR(36),
    install_id VARCHAR(36),
    device_id  VARCHAR(36),

    installed_at TIMESTAMP,

    date_sk INT,
    client_sk INT,
    channel_sk INT
);


CREATE TABLE client_dim (
    client_sk   INTEGER,

    os_name     VARCHAR(256),
    app_name    VARCHAR(256),
    app_version VARCHAR(256),
    device_name VARCHAR(256),

    PRIMARY KEY (client_sk)
);

INSERT INTO
    client_dim
VALUES
    (0, 'android', '8fit', '1', 'galaxy'),
    (1, 'android', '8fit', '0.12', 'motorola'),
    (2, 'ios', '8fit', '2', 'iphone'),
    (3, 'ios', '8fit', '2', 'ipad'),
    (4, 'ios', '8fit-pro', '1.3', 'iphone'),
    (5, 'msdos', '80fat', 'ballon', 'winphone');


CREATE TABLE IF NOT EXISTS dwh.channel_dim (
    channel_sk INT,

    channel_name TEXT,
    channel_group TEXT,
    channel_label TEXT,

    PRIMARY KEY (channel_sk)
);

INSERT INTO
    dwh.channel_dim
VALUES
    (0, 'facebook', 'social media', 'fb'),
    (1, 'twitter', 'social media', 'twt'),
    (2, 'referral', 'direct link', 'ref'),
    (3, 'direct', 'direct link', 'dir'),
    (4, 'paid user', 'forced', 'paid'),
    (5, 'fake research', 'forced', 'fake');
