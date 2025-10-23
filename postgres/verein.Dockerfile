FROM docker.io/library/postgres:17.6@sha256:243a1ae1d1ef200ee0526618cbbab370c306a4046fb6a977061147dbaa292b9c

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d