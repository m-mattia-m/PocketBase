#!/bin/sh
set -e

# If both env vars are set, upsert the superuser
if [ -n "$PB_SUPERUSER_EMAIL" ] && [ -n "$PB_SUPERUSER_PASSWORD" ]; then
  if [ ${#PB_SUPERUSER_PASSWORD} -lt 8 ]; then
    echo "ERROR: PB_SUPERUSER_PASSWORD must be at least 8 characters long."
    echo "Refusing to start PocketBase."
    exit 1
  fi

  echo "Ensuring PocketBase superuser exists for $PB_SUPERUSER_EMAIL ..."
  if ! /pb/pocketbase superuser upsert "$PB_SUPERUSER_EMAIL" "$PB_SUPERUSER_PASSWORD"; then
    echo "Failed to upsert superuser. Check credentials and permissions."
    exit 1
  fi
else
  echo "PB_SUPERUSER_EMAIL or PB_SUPERUSER_PASSWORD not set. Skipping superuser creation."
fi

# --- Start PocketBase ---
echo "Starting PocketBase..."
exec /pb/pocketbase "$@"