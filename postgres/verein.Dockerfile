FROM docker.io/library/postgres:17.4@sha256:45f3f7573df5db5df766ffd8260113db140a40d0ff990f7dd4a68274e8e2c390

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d