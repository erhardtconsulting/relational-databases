FROM docker.io/library/postgres:17.6@sha256:8e5293306f65f386445ed37940abc590be73bf48986a879941fa866c45283b82

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d