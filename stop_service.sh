#!/bin/bash

echo "Stopping Let-sCode services..."

# Stop Django servers
pkill -f "manage.py runserver"

# Stop Celery Worker
pkill -f "celery.*worker"

# Stop Celery Beat
pkill -f "celery.*beat"

# Stop Redis
pkill redis-server

echo "=================================="
echo " All services stopped."
echo "=================================="