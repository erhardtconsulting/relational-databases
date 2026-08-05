FROM docker.io/library/postgres:17.10@sha256:ccb771565a9685249a794529986c6f6eb007c676dd4169d84d3f1c46a280e696

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d