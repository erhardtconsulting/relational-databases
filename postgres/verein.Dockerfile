FROM docker.io/library/postgres:17.12@sha256:cdbfb3de010ef603c29f10a5dfc79e023f66ad662ec6fddcda7130afe5d65e7b

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d