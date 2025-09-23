FROM docker.io/library/postgres:17.6@sha256:6e1474849477e0e976e6318229cdef4f9e66dbb3ad26324d558c25614ced641c

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d