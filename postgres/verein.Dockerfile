FROM docker.io/library/postgres:17.5@sha256:fc50da4d6d6bb989a167cf8c48317a2a9e9387bd8b9067a2750daa9eca73a4f6

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d