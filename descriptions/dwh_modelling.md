### DWH modelling

For now our Redshift cluster is our main source for people to access information. In this position you might end up writing a SQL query every now and then. Please go through the following questions and provide your answer in a `*.sql` file somewhere in the repo.

Given the following table definition

```sql
CREATE TABLE IF NOT EXISTS dwh.user_first_install_fact (
    user_id VARCHAR(36),
    install_id VARCHAR(36),
    device_id  VARCHAR(36),
    installed_at TIMESTAMP,
    date_sk INT,
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

CREATE TABLE client_dim (
    client_sk   INTEGER,
    os_name     VARCHAR(256),
    app_name    VARCHAR(256),
    app_version VARCHAR(256),
    device_name VARCHAR(256),
    PRIMARY KEY (client_sk)
);

CREATE TABLE IF NOT EXISTS dwh.channel_dim (
    channel_sk INT,
    channel_name TEXT,
    channel_group TEXT,
    channel_label TEXT,
    PRIMARY KEY (channel_sk)
);
```

#### Question 1

Write a query, using Redshift ANSI SQL, to find which `user_id` has duplicated installs (more than one install) for yesterday.

#### Question 2

Write a query, using Redshift ANSI SQL, to know which are the top 5 channels with the most installs coming in from Android.