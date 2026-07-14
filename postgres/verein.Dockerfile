FROM docker.io/library/postgres:17.10@sha256:ebba4f4de37f08f138f97c1443c987a435e783177afedcc4aaf2da1930fbc37a

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d