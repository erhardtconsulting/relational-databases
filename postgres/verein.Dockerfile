FROM docker.io/library/postgres:17.10@sha256:3a83c3e2e6f5507ba4bfd2f2981936d055f81a40c08d7ea80f7a5e46d6512d6e

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d