FROM docker.io/library/postgres:17.6@sha256:e6a4209d1a4893f2df3bdcde58f8926c3c929c4d51df90990ed1b36d83c1382a

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d