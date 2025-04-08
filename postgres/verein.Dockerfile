FROM docker.io/library/postgres:17.4@sha256:6e57135d237944dddf7588b249edcdf78745a7c318e5444ae0375855b64ec6cf

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d