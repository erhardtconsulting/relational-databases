FROM docker.io/library/postgres:17.6@sha256:5fb46253e1013a88b275458e753cdb174fdb3ab4bf10a997c8ee8c16b31d8c81

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d