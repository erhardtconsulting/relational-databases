FROM docker.io/library/postgres:17.11@sha256:c469d92cbb89e123ba7c2c7c1a8815572943584085c37b007bacb43150a8c9e4

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d