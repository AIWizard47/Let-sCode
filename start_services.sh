#!/bin/bash

echo "Starting services..."

source ~/.virtualenvs/codeeditor/bin/activate

gnome-terminal -- bash -c "cd ~/CodePlatform && python manage.py runserver"
gnome-terminal -- bash -c "redis-server"
gnome-terminal -- bash -c "cd ~/CodePlatform && celery -A CodePlatform worker --pool=solo -l info"
gnome-terminal -- bash -c "cd ~/CodePlatform && celery -A CodePlatform beat -l info"
gnome-terminal -- bash -c "cd ~/Sandbox && python manage.py runserver 8080"