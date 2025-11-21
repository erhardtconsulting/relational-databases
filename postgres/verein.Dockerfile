FROM docker.io/library/postgres:17.7@sha256:f337b026cb1fb954a93f2e33a62bf9ea7fffc1dafc1586c53b93922a8d6ee018

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d