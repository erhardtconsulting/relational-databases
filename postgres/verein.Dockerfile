FROM docker.io/library/postgres:17.6@sha256:af5fa668fd423e463dd77225cc5ad88bb49979cbed8f7b551f350c9a2b039d41

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d