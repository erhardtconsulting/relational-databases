FROM docker.io/library/postgres:17.11@sha256:f86c774c7a51d0f05133f2ab70e4c384b589170458ab1df1ba83426d7cc30da7

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d