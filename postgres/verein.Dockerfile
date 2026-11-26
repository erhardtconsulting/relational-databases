FROM docker.io/library/postgres:19.0@sha256:4ea94de574c17f0372722806c949757050fbb1cd7648410fe45d6bba275cc00e

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d