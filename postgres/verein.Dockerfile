FROM docker.io/library/postgres:17.6@sha256:ab24d83d6a893f98acde5cd4264ab3c94329313c92ba92c71c2e7ce49ca8b1c6

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d