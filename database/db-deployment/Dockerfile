# Use the official PostgreSQL image as base
FROM postgres:latest

# Copy the initialization SQL script and CSV file to the Docker container
COPY init.sql /docker-entrypoint-initdb.d/
COPY data.csv /data/

# Grant permissions to the CSV file
RUN chown postgres:postgres /data/data.csv && chmod 644 /data/data.csv

# Execute init.sql
#RUN psql -U postgres -d postgres -f /docker-entrypoint-initdb.d/init.sql

# Expose the PostgreSQL port (5432 by default)
EXPOSE 5432

