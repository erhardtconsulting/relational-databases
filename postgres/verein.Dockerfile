FROM docker.io/library/postgres:17.9@sha256:6fd8445ad3e5c8413b7a2f002c639ea5581d633317d142e556506e62d0018e24

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d