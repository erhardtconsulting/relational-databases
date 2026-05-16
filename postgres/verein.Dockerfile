FROM docker.io/library/postgres:17.10@sha256:538bdb8c6b278f2f09070a4d79f04a83363a795ed23ec0d92d6b70cabc398eae

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d