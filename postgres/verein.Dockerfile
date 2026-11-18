FROM docker.io/library/postgres:17.12@sha256:58b1ad1807d86ca43d0e37fded9f0a899a7ab8763fa9576a63059a52de223e1b

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d