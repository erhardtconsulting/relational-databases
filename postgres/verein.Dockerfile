FROM docker.io/library/postgres:17.7@sha256:ecebd237d9aaf83112427807848bc41ba6bd4df8a2f6936e09f7db1813609625

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d