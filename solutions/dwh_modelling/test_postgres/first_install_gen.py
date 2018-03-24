import pendulum as pdm
import psycopg2
import random
import uuid

user_ids = ['8fit%s' % (uuid.uuid4().hex) for _ in range(random.randint(5, 20))]
device_ids = ['8fit%s' % (uuid.uuid4().hex) for _ in range(random.randint(20, 30))]


# can be public (gonna die soon)
pg_credentials = {
    'host': 'test8fit.cyo5dx3thmsn.us-east-1.rds.amazonaws.com',
    'user': 'test8fit',
    'dbname': 'test8fit',
    'port': 5432,
    'password': 'LYfyTA6tKohIRp4KUlthN6kAiQRdqPxEsCRwY4jNfaeo0U7e1L'
}

now = pdm.utcnow()
two_days_ago = int(now.subtract(days=2).timestamp())
now = int(now.timestamp())

values = list()
for i in range(random.randint(50, 100)):
    user_id = random.choice(user_ids)
    install_id = '8fit%s' % (uuid.uuid4().hex)
    device_id = random.choice(device_ids)

    timestamp = random.randint(two_days_ago, now)

    client_sk = random.choice([0, 1, 2, 3, 4, 5])
    channel_sk = random.choice([0, 1, 2, 3, 4, 5, 6, 7])

    value = "('%s', '%s', '%s', to_timestamp(%d), NULL, %d, %d)" % (user_id, install_id,
                                                                    device_id, timestamp,
                                                                    client_sk, channel_sk)
    values.append(value)

values = ', '.join(values)

pg_conn = psycopg2.connect(**pg_credentials)
pg_cur = pg_conn.cursor()
pg_cur.execute("INSERT INTO dwh.user_first_install_fact VALUES %s" % values)
pg_conn.commit()
