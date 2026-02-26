FROM docker.io/library/postgres:17.8@sha256:69dddb030ab69d669d8d7c6abf67aeb448178e5270d5f123a21f4f7ac8b46a24

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d