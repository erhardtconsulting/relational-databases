FROM docker.io/library/postgres:17.10@sha256:39fb82e41109483c81ac15422a302500b4a753777b47f8431038703536bc6c52

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d