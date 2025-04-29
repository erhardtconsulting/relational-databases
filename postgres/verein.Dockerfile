FROM docker.io/library/postgres:17.4@sha256:4aed4b0525233308fc5de1b8d47f92326460d598dc5f004d14b41f183360b4e9

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d