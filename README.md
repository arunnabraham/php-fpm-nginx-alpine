# PHP FPM Image

## Build Image

`docker build -t php-fpm-alpine . --no-cache`

## Run Alpine Image

format: docker run -p `hostport`:`containerport` -it imagename:version

`docker run -p 8000:80 --rm -it php-fpm-alpine:latest`

### Daemonise Docker run

`docker run -d -p 8000:80 --rm -it php-fpm-alpine:latest`

### Run the server on Client system (PC or host system)

<http://localhost:8000>

### Restart, build and run container

Note: This is used for development purpose only

`docker stop $(docker container ps --latest --quiet) && docker build -t php-fpm-alpine:latest . && docker run -d -p 8000:80 --rm -it php-fpm-alpine:latest`

Run the Macro script: `./rebuild-restart-container.sh` in git-bash or cygwin in windows.

If you use linux, make the script executable and run.

Example:

Making script executable (one time): `chmod +x ./rebuild-restart-container.sh`

Run script (each time you want to rebuild the image with file changes): `./rebuild-restart-container.sh`
