FROM docker.io/library/postgres:17.9@sha256:681f6b2a528c5ef8c162859b778b7e1e27728c977f587a495f34e28b041901f7

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d