FROM docker.io/library/postgres:17.10@sha256:9cbd488d3dcffbaf057f994444c92c07901a6bda67799b6712160e813fcdff23

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d