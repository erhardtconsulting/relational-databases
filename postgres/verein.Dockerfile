FROM docker.io/library/postgres:17.7@sha256:dca7512acaa113409df7e40d977d801e53c0c8088e45d4311a45b4065ccfdcd3

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d