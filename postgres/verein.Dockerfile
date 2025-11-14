FROM docker.io/library/postgres:17.7@sha256:44640f16641cf36716cabd011e2f7eb4742b6b6b19f4488ddcbb7c250e5c9753

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d