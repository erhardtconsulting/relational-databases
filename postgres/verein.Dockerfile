FROM docker.io/library/postgres:17.7@sha256:1c2b6ae7bd9b9a334a956ea3b6fb9681351991e68fc1d6e8d3c6aa94fc43254a

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d