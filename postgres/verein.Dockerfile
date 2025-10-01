FROM docker.io/library/postgres:17.6@sha256:5e3f6d990b8d63d43046b95d0a1ca895c4186b6050276851ffe3fd9f9b1167aa

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d