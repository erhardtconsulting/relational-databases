FROM docker.io/library/postgres:17.6@sha256:b480430782a9bd1c8a6835fb5b70f89f34a70132c2f6182e534f65688bce063b

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d