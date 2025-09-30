FROM docker.io/library/postgres:17.6@sha256:43ae6bececb087845191590d1b79106edc1a0db66fc7bd67c703fbabeeaa3ab1

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d