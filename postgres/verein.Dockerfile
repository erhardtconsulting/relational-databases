FROM docker.io/library/postgres:17.10@sha256:ea206dba4203bf62bc772fa7e1a51990a2b7f7f91390ab0a6098e4b20ba95d47

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d