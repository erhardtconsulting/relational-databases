FROM docker.io/library/postgres:17.6@sha256:8a56bef4c60bef3d26193cb9d810fce93def8fd0c459f4a9b14240fbd7559a1d

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d