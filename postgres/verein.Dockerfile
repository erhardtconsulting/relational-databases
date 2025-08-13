FROM docker.io/library/postgres:17.5@sha256:fa6e5715d6521a4a9d4cc47015b6eb8fc4f2abaae4bc015be7a5209328ce196c

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d