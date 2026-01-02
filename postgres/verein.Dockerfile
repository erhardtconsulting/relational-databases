FROM docker.io/library/postgres:18.1@sha256:bfe50b2b0ddd9b55eadedd066fe24c7c6fe06626185b73358c480ea37868024d

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d