FROM docker.io/library/postgres:17.8@sha256:4ca8a213e99aa822bf3045af572b9699fe52f97da3a9c93c8d8be973ec5e076a

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d