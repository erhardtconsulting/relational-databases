FROM docker.io/library/postgres:17.4@sha256:81f32a88ec561664634637dd446487efd5f9d90996304b96210078e90e5c8b21

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d