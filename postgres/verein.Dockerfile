FROM docker.io/library/postgres:17.5@sha256:4d89c904835259bc58876520e56267ca07a4ebd6a027f7814bbbf91b50d685be

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d