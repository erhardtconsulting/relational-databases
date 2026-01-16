FROM docker.io/library/postgres:18.1@sha256:5773fe724c49c42a7a9ca70202e11e1dff21fb7235b335a73f39297d200b73a2

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d