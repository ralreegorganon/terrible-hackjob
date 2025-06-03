#!/bin/bash

echo "Waiting for PostGIS to be ready..."

# Use ogrinfo to test the connection
until ogrinfo -ro PG:"host=$PGHOST port=$PGPORT dbname=$PGDATABASE user=$PGUSER password=$PGPASSWORD" 2>/dev/null | grep -q "INFO"; do
  echo "Waiting for database connection..."
  sleep 2
done

echo "PostGIS is ready!"

# Import all shapefiles in the data directory
for file in /data/*.shp; do
  if [ -f "$file" ]; then
    filename=$(basename "$file" .shp)
    echo "Importing $filename..."

    ogr2ogr -f "PostgreSQL" \
      PG:"host=$PGHOST port=$PGPORT dbname=$PGDATABASE user=$PGUSER password=$PGPASSWORD" \
      "$file" \
      -nln "$filename" \
      -overwrite \
      -progress \
      -nlt PROMOTE_TO_MULTI

    if [ $? -eq 0 ]; then
      echo "Successfully imported $filename"
    else
      echo "Failed to import $filename"
    fi
  fi
done

# Import CSV files
for file in /data/*.csv; do
  if [ -f "$file" ]; then
    filename=$(basename "$file" .csv)
    echo "Importing CSV: $filename..."
    
    # Import as regular table without geometry
    ogr2ogr -f "PostgreSQL" \
      PG:"host=$PGHOST port=$PGPORT dbname=$PGDATABASE user=$PGUSER password=$PGPASSWORD" \
      "$file" \
      -nln "$filename" \
      -overwrite \
      -progress \
      -oo AUTODETECT_TYPE=YES

    if [ $? -eq 0 ]; then
      echo "Successfully imported CSV: $filename"
    else
      echo "Failed to import CSV: $filename"
    fi
  fi
done

echo "All imports completed!"
