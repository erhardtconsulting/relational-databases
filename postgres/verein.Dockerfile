FROM docker.io/library/postgres:17.7@sha256:4ad49a4ba70130eab1de69bdd7a212d9c711e7410f10e1a23aae41a325b95093

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d