FROM docker.io/library/postgres:17.7@sha256:4493696c5ba6a9cd4a3303411d5dd6af52cf5e34cdd87ba8ebf26a19735f84d1

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d