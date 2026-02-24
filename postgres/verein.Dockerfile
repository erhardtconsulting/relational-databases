FROM docker.io/library/postgres:17.8@sha256:9ba47fa6d1c34e9cc4c1758640e7774a9b73ea0fba891f14088321ba7561d253

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d