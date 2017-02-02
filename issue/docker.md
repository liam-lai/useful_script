### getting code into a container

- Using RUN git clone ... in a Dockerfile and build the image each time the source code changes.
- Get the source code to the host and use COPY . /whatever in the Dockerfile.
- Get the source code to the host and use docker run -v $(pwd):/whatever/

[Ref](https://forums.docker.com/t/best-practices-for-getting-code-into-a-container-git-clone-vs-copy-vs-data-container/4077)
