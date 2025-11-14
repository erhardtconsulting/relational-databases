FROM docker.io/library/postgres:17.7@sha256:46fd7ee75065e6ddd1949d332289c589269c92701d572e7bc373c15c6c153267

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d