FROM docker.io/library/postgres:17.7@sha256:23ff8843f1502b70e27910b4e3bc448b21973b56565cf2b6b53bf1bc73cf8c29

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d