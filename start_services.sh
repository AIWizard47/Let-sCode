#!/bin/bash

echo "Starting services..."

cd /home/kali/Desktop/Let-sCode/CodePlatform
source .venv/bin/activate

nohup python manage.py runserver 0.0.0.0:8000 > logs/django.log 2>&1 &

nohup redis-server > logs/redis.log 2>&1 &

nohup celery -A CodePlatform worker --pool=solo -l info > logs/celery_worker.log 2>&1 &

nohup celery -A CodePlatform beat -l info > logs/celery_beat.log 2>&1 &

cd /home/kali/Desktop/Let-sCode/Sandbox
source .venv/bin/activate

nohup python manage.py runserver 0.0.0.0:8080 > logs/sandbox.log 2>&1 &

echo "All services started."