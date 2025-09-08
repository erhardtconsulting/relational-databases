FROM docker.io/library/postgres:17.6@sha256:7be29db83c6f7084804058fe18952f19424fdab3131caaaf2e90dd21076e0341

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d