FROM docker.io/library/postgres:17.11@sha256:14b34a26eed1fb911c7e8f7c55c1fbd14a4fd5d7cf3ed69e5ce4c3eefe630cbb

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d