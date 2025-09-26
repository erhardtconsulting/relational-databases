FROM docker.io/library/postgres:17.6@sha256:cecd364cc7ec03ab6148ab650efc5200548a89fd2e4f47a8ba6e6cf08c18805d

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d