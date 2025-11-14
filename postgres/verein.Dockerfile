FROM docker.io/library/postgres:17.7@sha256:5e3334661512bc0783dd748bec4419105ee6aa463d1604d13087c29c4894c83e

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d