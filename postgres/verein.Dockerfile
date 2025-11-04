FROM docker.io/library/postgres:17.6@sha256:5b5b35a7f494e5f12b94df7e1c6fdfaaceb32230eb04b6214a8aedf2bab57010

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d