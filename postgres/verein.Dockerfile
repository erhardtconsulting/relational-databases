FROM docker.io/library/postgres:17.5@sha256:016154be900bddeac413c2ed2d03b7fdc38799a18e61ecf250d19f0973693de1

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d