FROM docker.io/library/postgres:17.5@sha256:0f9d52b237395d0512efd1e5493ac9bd60606839994422bba9bfa7ab3ddc32ea

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d