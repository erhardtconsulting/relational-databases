FROM docker.io/library/postgres:17.7@sha256:bac8128cd62a35471a1e97966861aa2ac88c8d2f408767a425ae70695a607c99

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d