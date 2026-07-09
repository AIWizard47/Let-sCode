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

nohup python /home/kali/Desktop/Let-sCode/CodePlatform/Code/manage.py runserver 0.0.0.0:8000 > /home/kali/Desktop/Let-sCode/CodePlatform/logs/django.log 2>&1 &

nohup redis-server > /home/kali/Desktop/Let-sCode/CodePlatform/logs/redis.log 2>&1 &

nohup celery -A /home/kali/Desktop/Let-sCode/CodePlatform/Code/CodePlatform worker --pool=solo -l info > /home/kali/Desktop/Let-sCode/CodePlatform/logs/celery_worker.log 2>&1 &

nohup celery -A /home/kali/Desktop/Let-sCode/CodePlatform/Code/CodePlatform beat -l info > /home/kali/Desktop/Let-sCode/CodePlatform/logs/celery_beat.log 2>&1 &

# -----------------------------
# Sandbox
# -----------------------------
cd /home/kali/Desktop/Let-sCode/sandbox/SandBox || exit

# Create logs directory if it doesn't exist
mkdir -p logs

nohup python /home/kali/Desktop/Let-sCode/sandbox/SandBox/manage.py runserver 0.0.0.0:8080 > /home/kali/Desktop/Let-sCode/sandbox/logs/sandbox.log 2>&1 &

echo "=================================="
echo " All services started successfully"
echo "=================================="