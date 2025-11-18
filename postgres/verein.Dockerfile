FROM docker.io/library/postgres:17.7@sha256:5ecd7c63c618bed8b554567d3e9959636956be2058d8acbf12d0313dd16f67f8

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d