FROM docker.io/library/postgres:17.11@sha256:a6ec007920913e8d715a41e68a17b05ddf30e62d69565814988a896767594cc6

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d