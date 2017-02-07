### Build an image from dockerfile

EX: docker build -t name:tag dockerfile_dir 
docker build -t New_image:v1 docker_golang_1.7 

### Docker upload image to docker hub

! image name must the same as your public repo

docker build -t ic09272002/hello_world .
docker login -u=username -p=userpass
docker push ic09272002/hello_world

### Delete multiple containers

docker rm $(docker ps -a -q)  #delete all containers

### Docker run command and parameter

EX: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

docker run -it hello:v1 ls -a
docker run -d hello:v2 ls /

* -i, --interactive    Keep STDIN open even if not attached
* -t, --tty            Allocate a pseudo-TTY 
* -d, --detach         Run container in background and print container ID
* -p, --publish list   Publish a container's port(s) to the host (default [])
