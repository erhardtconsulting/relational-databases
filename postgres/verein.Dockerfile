FROM docker.io/library/postgres:17.8@sha256:5be49f2625d42a4ce42e1dc28288d5523343c2f5561589143fe03a14fffe0deb

# Set default admin password (hftm_admin)
ENV POSTGRES_PASSWORD=hftm_admin

COPY ./sql/verein/0-schema.sql /docker-entrypoint-initdb.d
COPY ./sql/verein/1-data.sql /docker-entrypoint-initdb.d