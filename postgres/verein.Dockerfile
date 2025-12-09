FROM docker.io/library/postgres:17.7@sha256:929190a12e0833c89276f78c7cf665aaaa62b5930e6f852e9f733f8b737d3f8f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d