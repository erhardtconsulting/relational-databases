FROM docker.io/library/postgres:17.6@sha256:0f4f20021a065d114083d1b95d9fb89ad847cbc4c3cc9238417815c7df42350f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d