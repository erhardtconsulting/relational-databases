FROM docker.io/library/postgres:17.7@sha256:2b6239f32680c308921cf212902f881355c31ae92da0795b4fef29d8f0033021

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d