FROM docker.io/library/postgres:17.6@sha256:5250e6187084ddf4ba407027d07eed2419d4656e30821afef43825c6c0d127df

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d