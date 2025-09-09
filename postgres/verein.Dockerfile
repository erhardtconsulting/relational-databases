FROM docker.io/library/postgres:17.6@sha256:29574e213ffaf433ca9c9441a5919868b85ec04e7a32377f48edd3d3f972103d

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d