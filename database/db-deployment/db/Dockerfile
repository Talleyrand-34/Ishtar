# Use the official PostgreSQL image as base
FROM postgres:latest

ADD ./scripts/1_init.sql /docker-entrypoint-initdb.d
ADD ./scripts/2_copy.sql /docker-entrypoint-initdb.d
RUN chmod a+r /docker-entrypoint-initdb.d/*

# Expose the PostgreSQL port (5432 by default)
EXPOSE 5432

# Import data from CSV after database initialization
# CMD ["bash", "-c", "psql -U postgres -d postgres -c \"\\COPY products FROM '/data/products.csv' DELIMITER ';' CSV HEADER;\""]

