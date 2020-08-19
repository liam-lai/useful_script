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

### getting code into a container

- Using RUN git clone ... in a Dockerfile and build the image each time the source code changes.
- Get the source code to the host and use COPY . /whatever in the Dockerfile.
- Get the source code to the host and use docker run -v $(pwd):/whatever/

[Ref](https://forums.docker.com/t/best-practices-for-getting-code-into-a-container-git-clone-vs-copy-vs-data-container/4077)
