#!/bin/bash

# Get current date.
now=$(date +"%d-%b-%Y")


# Restoring web folder.
cd /path/to/dockerized-php5.6-fpm/
docker run --rm -it -v $(docker inspect --format '{{ range .Mounts }}{{ if eq .Destination "/var/www/html/website" }}{{ .Name }}{{ end }}{{ end }}' $(docker-compose ps -a -q website)):/website -v /backup/website:/backup debian:stretch-slim tar xvfz /backup/website_web-$now.tar
