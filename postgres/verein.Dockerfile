FROM docker.io/library/postgres:17.6@sha256:0b6428e8c09651398137d2b3308a6ad87e73ac15fc38729891c16d942e947d3d

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d