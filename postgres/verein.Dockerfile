FROM docker.io/library/postgres:17.9@sha256:4d3b957c9337f15fb7f762be430ba0b3ae78f08c5f5571f5c62ef676c40d39b9

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d