#!/bin/bash

# Run supervisord
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
