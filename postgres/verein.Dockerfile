FROM docker.io/library/postgres:17.5@sha256:8e0059697e15b2067733fe2e3d95df33dc17d639bdd887a9881483b4222c3933

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d