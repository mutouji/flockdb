#!/bin/sh

if java -version 2>&1 |grep "1\.5"; then
  echo "Java must be at least 1.6"
  exit 1
fi

if [ "x$DB_USERNAME" = "x" -o "x$DB_PASSWORD" = "x" ]; then
  echo "Please set DB_USERNAME and DB_PASSWORD."
  exit 1
fi

echo "Killing any running flockdb..."
curl http://localhost:9990/shutdown >/dev/null 2>/dev/null
sleep 3

echo "Launching flock..."
ant -q launch
sleep 5

echo "Creating shards..."
echo "CREATE DATABASE IF NOT EXISTS flockdb_development" | mysql -u$DB_USERNAME -p$DB_PASSWORD
i=1
while [ $i -lt 15 ]; do
  echo "DROP TABLE IF EXISTS edges_development.forward_${i}_edges" | mysql -u$DB_USERNAME -p$DB_PASSWORD
  echo "DROP TABLE IF EXISTS edges_development.forward_${i}_metadata" | mysql -u$DB_USERNAME -p$DB_PASSWORD
  echo "DROP TABLE IF EXISTS edges_development.backward_${i}_edges" | mysql -u$DB_USERNAME -p$DB_PASSWORD
  echo "DROP TABLE IF EXISTS edges_development.backward_${i}_metadata" | mysql -u$DB_USERNAME -p$DB_PASSWORD
  i=$((i + 1))
done

./src/scripts/flocker.rb -D setup-dev
