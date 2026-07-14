FROM docker.io/library/postgres:17.10@sha256:4ffc96598f8965ee5b33b4186ab4f1ca4df7f4f0325f06d17c19d18e51d3f107

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d