FROM docker.io/library/postgres:17.5@sha256:3962158596daaef3682838cc8eb0e719ad1ce520f88e34596ce8d5de1b6330a1

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d