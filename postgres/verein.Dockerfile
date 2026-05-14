FROM docker.io/library/postgres:17.10@sha256:2293160ed74e619c591f6c52f956eefe2092d07d440a0bbb518753973d612af7

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d