FROM docker.io/library/postgres:17.6@sha256:603395c235c99984271a59a6476eed9db4f584e85ba64f9f49a65ba835882f33

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d