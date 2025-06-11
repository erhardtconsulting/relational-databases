FROM docker.io/library/postgres:17.5@sha256:62d6869ec6d5b30b53ee45e102a952990be578189a8abc5804bfdebeb4f9f542

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d