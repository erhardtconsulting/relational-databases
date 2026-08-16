FROM docker.io/library/postgres:17.11@sha256:e38411452a464af89e5adadb8d223bf53b898d47d6ef918b2d58c08707350449

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d