FROM docker.io/library/postgres:17.7@sha256:11cf4dcbc5181663d0227de04b70b8b48e59560755af23f2b279ba88ad8937b6

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d