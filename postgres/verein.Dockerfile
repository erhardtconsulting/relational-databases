FROM docker.io/library/postgres:17.11@sha256:c6222b54873a2fb19591cb06b93ef2825c03cdb680396e3600f24921f340f630

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d