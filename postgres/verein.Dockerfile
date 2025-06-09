FROM docker.io/library/postgres:17.5@sha256:30a72339ce74f2621f0f82cd983a11ade307ec2e634a7998318e8813a6f6f25c

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d