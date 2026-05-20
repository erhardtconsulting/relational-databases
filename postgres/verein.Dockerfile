FROM docker.io/library/postgres:17.10@sha256:3faba5d113bdbdfda79ed7f0d68ddae736d17473e8888e250f2471c651694f3f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d