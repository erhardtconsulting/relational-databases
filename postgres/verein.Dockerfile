FROM docker.io/library/postgres:17.10@sha256:0027bef26712baaee437a4ea48fdf3d2d2e2bc5f0d81615374408ca320f3c7e3

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d