FROM docker.io/library/postgres:17.4@sha256:cdb3f383b3e4c996be74f758377d272b0c8eb1ab2c227349933bf52d363685cc

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d