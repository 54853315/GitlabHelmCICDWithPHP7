#!/usr/bin/env bash

# Add more custom commands here if needed

set -e

exec supervisord -c /etc/supervisor/supervisord.conf
