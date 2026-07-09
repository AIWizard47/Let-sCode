#!/bin/bash

echo "Starting services..."

TERMINAL=xfce4-terminal

$TERMINAL --hold -e "bash -c 'cd ~/CodePlatform && source .venv/bin/activate && python manage.py runserver'"

$TERMINAL --hold -e "bash -c 'redis-server'"

$TERMINAL --hold -e "bash -c 'cd ~/CodePlatform && source .venv/bin/activate && celery -A CodePlatform worker --pool=solo -l info'"

$TERMINAL --hold -e "bash -c 'cd ~/CodePlatform && source .venv/bin/activate && celery -A CodePlatform beat -l info'"

$TERMINAL --hold -e "bash -c 'cd ~/Sandbox && source .venv/bin/activate && python manage.py runserver 8080'"