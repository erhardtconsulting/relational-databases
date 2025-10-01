FROM docker.io/library/postgres:17.6@sha256:bb51eb307fdaa5abc9866ab9ff9b93dbe639a56d0345e078ff7f96f39a22252e

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d