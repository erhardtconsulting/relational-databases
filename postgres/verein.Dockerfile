FROM docker.io/library/postgres:17.9@sha256:b994732fcf33f73776c65d3a5bf1f80c00120ba5007e8ab90307b1a743c1fc16

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d