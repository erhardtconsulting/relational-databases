FROM docker.io/library/postgres:17.5@sha256:0d5b8e334c933cec2fb09b4b6489fb7fb83a0c63cf7ded3528d8b6a8d5cddf4f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d