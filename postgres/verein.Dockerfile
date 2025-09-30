FROM docker.io/library/postgres:17.6@sha256:14d1abe0b1c660ec3c7521786d1249157699ebc62b07ea84ab6aad5239f5251f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d