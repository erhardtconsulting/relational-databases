FROM docker.io/library/postgres:17.4@sha256:304ab813518754228f9f792f79d6da36359b82d8ecf418096c636725f8c930ad

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d