#!/bin/sh
set -e

echo "Initialising PawBook database..."

python -c "from app import app, db; app.app_context().push(); db.create_all()"

echo "Starting PawBook web server..."

exec gunicorn \
    --bind "0.0.0.0:${PORT:-10000}" \
    --workers 1 \
    --threads 4 \
    --timeout 120 \
    app:app