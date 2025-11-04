FROM docker.io/library/postgres:17.6@sha256:1da445c15f55eb86a84b2aaaf552465c48eb5cdbaa316c368a2480b1c0b39051

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d