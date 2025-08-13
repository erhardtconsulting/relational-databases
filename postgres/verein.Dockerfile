FROM docker.io/library/postgres:17.5@sha256:7a554f408a1bc37f29e1e81757368cffa330619d017d235822223be538d37f5a

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d