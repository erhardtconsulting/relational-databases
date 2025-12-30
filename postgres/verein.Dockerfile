FROM docker.io/library/postgres:17.7@sha256:6a2fb9aaf22abf4c5aeeeb8fcd12dfb57b7531d8d5196f90cfe0ce3f68c4c13f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d