FROM docker.io/library/postgres:17.7@sha256:a1b54ad4d1781324a01774df9dc654e99c8ba4f693587a7af0a3c01affe20e5b

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d