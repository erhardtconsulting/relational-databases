FROM docker.io/library/postgres:18.0@sha256:1d288494853e244e7a78d87b3526e650e5221c622f9768ecac9313d0874a9c39

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d