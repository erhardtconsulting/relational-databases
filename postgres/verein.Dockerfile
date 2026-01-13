FROM docker.io/library/postgres:17.7@sha256:f070e09fa5b77a36d029cd57d8607ab83d290bc07bf463d8a42452ae360a191f

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d