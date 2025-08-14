FROM docker.io/library/postgres:17.6@sha256:a7fdfd815005ea658281c60b06020f49ab8a6bbe21434d3a59fe14654f6d4293

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d