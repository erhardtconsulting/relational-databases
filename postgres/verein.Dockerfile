FROM docker.io/library/postgres:17.4@sha256:f57cfa8e5c1b89d07c9cee525849772027c1d05b6668b1ee2ce64a4890ecb1ef

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d