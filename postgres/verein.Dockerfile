FROM docker.io/library/postgres:17.12@sha256:156d40cfa063d6babb15d329a8e15b26a8d0690ebb6084c956084f3b025c3b30

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d