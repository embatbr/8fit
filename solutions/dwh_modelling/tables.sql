-- Tables definition


-- First install of the app
-- A user can have multiples 1st install (if he/she has multiple devices)
-- Can a user have multiple installations for the same device? And multiple 1st installations?
-- How to know who is the user before login? Fingerprint? Or install == access?
CREATE TABLE IF NOT EXISTS dwh.user_first_install_fact (
    user_id VARCHAR(36), -- Assuming this info is easy to check (cookie or fingerprint)
    install_id VARCHAR(36),
    device_id  VARCHAR(36), -- Unique ID for each unique device

    installed_at TIMESTAMP,

    date_sk INT, -- References only a date type (YYYY-MM-DD) or datetime type?
    client_sk INT,
    channel_sk INT,

    country_code VARCHAR(7),
    network_name VARCHAR(256),
    campaign_name VARCHAR(256),
    adgroup_name VARCHAR(256),
    creative_name VARCHAR(256),
    campaign_id VARCHAR(256),
    adgroup_id VARCHAR(256),
    creative_id VARCHAR(256),
    ip_address VARCHAR(39)
);
-- Possible "primary" key: (user_id, device_id, client_sk)
-- Each installation has its own ID (install_id will always be unique - or at least should be)

-- Contains information about the app itself (e.g., "ios 8fit v1.0.1 iphone7" or
-- "android 8fit-pro-runner v.1.5.0 galaxy")
-- May not contain "too much" records (and that makes sense)
CREATE TABLE client_dim (
    client_sk   INTEGER,

    os_name     VARCHAR(256), -- if only Redshift had enumeration...
    app_name    VARCHAR(256),
    app_version VARCHAR(256),
    device_name VARCHAR(256), -- if only Redshift had enumeration...

    PRIMARY KEY (client_sk)
);

-- What is a channel? If the user was acquired from website itself, Facebook or referral link, for example?
-- e.g., Facebook is labeled FB and is in group "social media"?
CREATE TABLE IF NOT EXISTS dwh.channel_dim (
    channel_sk INT,

    channel_name TEXT,
    channel_group TEXT,
    channel_label TEXT,

    PRIMARY KEY (channel_sk)
);