FROM docker.io/library/postgres:17.7@sha256:2167ad9c70a2b1072fed967ee8bc8f397b6a2d705f7c0afc6a477a7791ef8749

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d