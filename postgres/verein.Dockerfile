FROM docker.io/library/postgres:17.12@sha256:223efeb196329b55b3b9a13db144956411dbc18e727e59f681c3e0aede6475cf

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d