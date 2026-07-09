#!/bin/bash

echo "Starting services..."

# Activate virtual environment
source /home/kali/Desktop/Let-sCode/.venv/bin/activate

# -----------------------------
# CodePlatform
# -----------------------------
cd /home/kali/Desktop/Let-sCode/CodePlatform/Code || exit

# Create logs directory if it doesn't exist
mkdir -p logs

nohup python manage.py runserver 0.0.0.0:8000 > logs/django.log 2>&1 &

nohup redis-server > logs/redis.log 2>&1 &

nohup celery -A CodePlatform worker --pool=solo -l info > logs/celery_worker.log 2>&1 &

nohup celery -A CodePlatform beat -l info > logs/celery_beat.log 2>&1 &

# -----------------------------
# Sandbox
# -----------------------------
cd /home/kali/Desktop/Let-sCode/sandbox/SandBox || exit

# Create logs directory if it doesn't exist
mkdir -p logs

nohup python manage.py runserver 0.0.0.0:8080 > logs/sandbox.log 2>&1 &

echo "=================================="
echo " All services started successfully"
echo "=================================="