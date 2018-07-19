# SANE Backend (with libusb1.0) build environment (Ubuntu) Dockerfile

## Base Docker Image

* [ubuntu:18.04](https://registry.hub.docker.com/u/library/ubuntu/)

## Download

```bash
docker pull vswteam/sane-backend-ubuntu-x64`
```

## Usage

```bash
docker run -it -v <sane-backend-volume>:/root/project vswteam/sane-backend-ubuntu-x64 /bin/bash
```
