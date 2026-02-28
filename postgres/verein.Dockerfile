FROM docker.io/library/postgres:17.9@sha256:2cd82735a36356842d5eb1ef80db3ae8f1154172f0f653db48fde079b2a0b7f7

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d