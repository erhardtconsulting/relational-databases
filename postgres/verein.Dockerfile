FROM docker.io/library/postgres:17.5@sha256:cb51e9f73d5b6fd77340999cc0fdfcf56a1d580daa6f4c2f6c72264993e6de34

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d