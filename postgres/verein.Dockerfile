FROM docker.io/library/postgres:18.1@sha256:41bfa2e5b168fff0847a5286694a86cff102bdc4d59719869f6b117bb30b3a24

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d