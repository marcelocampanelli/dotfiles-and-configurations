#!/bin/bash

echo "fs.inotify.max_user_watches=2097152" | sudo tee /etc/sysctl.d/99-watcher.conf
echo "fs.inotify.max_user_instances=2048" | sudo tee -a /etc/sysctl.d/99-watcher.conf
echo "fs.inotify.max_queued_events=65536" | sudo tee -a /etc/sysctl.d/99-watcher.conf

sudo sysctl --system