FROM docker.io/library/postgres:17.11@sha256:5bf4cdb7aa4b9241bcebf00f15933b1939c928d00f03a36395fbab28e02b8b31

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d