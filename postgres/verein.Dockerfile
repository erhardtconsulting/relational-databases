FROM docker.io/library/postgres:18.1@sha256:5ec39c188013123927f30a006987c6b0e20f3ef2b54b140dfa96dac6844d883f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d