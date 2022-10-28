---
title: "Container virtualisation"
subtitle: "Infrastructure Automation<br/>HOGENT applied computer science"
author: Bert Van Vreckem
date: 2021-2022
---

# Intro

## Container virtualisation

![](https://www.redhat.com/cms/managed-files/styles/wysiwyg_full_width/s3/virtualization-vs-containers_transparent.png?itok=q-E2I2-L)

<https://www.redhat.com/en/topics/containers/containers-vs-vms>

## Containers are old!

OS-level virtualization

- Mainframe
- Solaris Zones
- FreeBSD jails
- Linux Containers (LXC)
- ...

## And then came Docker...

<iframe width="560" height="315" src="https://www.youtube.com/embed/wW9CAH9nSLs" title="The future of Linux Containers" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Solomon Hykes @ PyCon 2013

## The promise...

- Lightweight VM => efficient use of resources
- App encapsulation: security
- Easier production deployment

# Lab environment setup

## Local lab environment

- Go to Chamilo, create a personal Github repo
    - => URL ~ https://github.com/hogenttin/infra-labs-2122-NAME

```console
git clone git@github.com/hogenttin/infra-labs-2122-NAME
cd infra-labs-2122-NAME
```

## Repo overview

- **assignment**: lab assignments
- **dockerlab**: Vagrant-environment for Docker labs
- **report**: your reports and cheat sheet
- **vmlab**: Vagrant-environment for Ansible labs

## Boot the Docker-VM

```console
$ cd dockerlab
$ vagrant status
Current machine states:

dockerlab                 not created (virtualbox)

$ vagrant up
```

## Docker-VM

- Ubuntu 20.04 LTS
- 4GiB RAM
- Installed software:
    - Docker, Docker-compose
    - Portainer
    - Useful commands
- Bash aliases

## Get started!

- Open the lab assignment in a webbrowser (assignment/1-containers.md)
- Open a browser tab with <http://192.168.56.20:9000> (Portainer UI)
- Follow the steps in the assignment!

# Important competencies

## Man-pages

```console
man docker-run
man docker-exec
man docker-<TAB><TAB>
```

## Images

```console
docker image ls
docker pull
```

## Containers

```console
docker run -d
docker run -i -t
docker exec -i -t
docker ps
docker container ls
```

## Volumes for persistent data

```console
docker volume ls
docker volume create VOLUME_NAME
docker volume inspect VOLUME_NAME
docker volume rm VOLUME_NAME
docker volume prune
```

## Custom images

Example Dockerfile:

```Dockerfile
FROM alpine:latest
LABEL description="This example Dockerfile installs NGINX."
RUN apk add --update nginx && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /tmp/nginx/
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/default.conf /etc/nginx/conf.d/default.conf
ADD files/site-contents.tar.bz2 /usr/share/nginx/
EXPOSE 80/tcp
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
```

## Custom images

```console
docker image build --tag local:static-site .
docker image ls
docker run -d -p 8080:80 --name websrv local:static-site
```

## Layered filesystem

```console
docker image inspect
docker image inspect alpine:latest | jq ".[]|.RootFS.Layers"
docker image history
```

## Docker-compose

```console
edit docker-compose.yml
docker-compose up -d
```

Example: <https://github.com/HoGentTIN/infra-labs/blob/main/dockerlab/labs/todo-app/docker-compose.yml>

# Reflection

## Beware of the golden hammer!

![](https://live.staticflickr.com/4918/45924389801_fe044ce044_b.jpg)

---

<https://www.slideshare.net/KrisBuytaert/moby-is-killing-your-devops-efforts>

## Is Docker suitable for production?

- Not everyone needs Docker!
- Don't run your production DB in Docker!
- [Containers will not fix your broken culture](https://queue.acm.org/detail.cfm?id=3185224)
- Containers are not VMs
    - max 1 service per container - microservices
- Dockerfile format only suitable for simple setup
    - more complex needs? Config Management!
