#!/bin/sh
set -e

DATA_DIR="${PB_DATA_DIR:-/pb_data}"

# Validate superuser
if [ -n "$PB_SUPERUSER_EMAIL" ] && [ -n "$PB_SUPERUSER_PASSWORD" ]; then
  if [ ${#PB_SUPERUSER_PASSWORD} -lt 8 ]; then
    echo "ERROR: PB_SUPERUSER_PASSWORD must be at least 8 characters long."
    exit 1
  fi

  echo "Ensuring PocketBase superuser exists for $PB_SUPERUSER_EMAIL ..."
  /pb/pocketbase superuser upsert "$PB_SUPERUSER_EMAIL" "$PB_SUPERUSER_PASSWORD" --dir "$DATA_DIR" || {
    echo "Failed to upsert superuser."
    exit 1
  }
else
  echo "PB_SUPERUSER_EMAIL or PB_SUPERUSER_PASSWORD not set. Skipping superuser creation."
fi

echo "Starting PocketBase..."
exec /pb/pocketbase serve --http=0.0.0.0:8080 --dir "$DATA_DIR"