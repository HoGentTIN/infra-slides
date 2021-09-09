---
title: "Container-virtualisatie"
subtitle: "Infrastructure Automation<br/>HOGENT toegepaste informatica"
author: Bert Van Vreckem
date: 2021-2022
---

# Intro

## Containervirtualisatie

![](https://www.redhat.com/cms/managed-files/styles/wysiwyg_full_width/s3/virtualization-vs-containers_transparent.png?itok=q-E2I2-L)

<https://www.redhat.com/en/topics/containers/containers-vs-vms>

## Containers bestaan al lang!

OS-level virtualization

- Mainframe
- Solaris Zones
- FreeBSD jails
- Linux Containers (LXC)
- ...

## En toen kwam Docker...

<iframe width="560" height="315" src="https://www.youtube.com/embed/wW9CAH9nSLs" title="The future of Linux Containers" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Solomon Hykes @ PyCon 2013

# Opstart labo

## Lokale werkomgeving

- Maak via Chamilo persoonlijke repo aan
    - => URL ~ https://github.com/hogenttin/infra-labs-2122-NAAM

```console
git clone git@github.com/hogenttin/infra-labs-2122-NAAM
cd infra-labs-2122-NAAM
```

## Overzicht repo

- **assignment**: de labo-opgaven
- **dockerlab**: Vagrant-omgeving voor Docker
- **report**: jouw verslagen en cheat sheet
- **vmlab**: Vagrant-omgeving voor config management labo

## Start de Docker-VM op

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
    - Handige commando's
- Aliases

## Get started!

- Open de labo-opdracht in een webbrowser (assignment/1-containers.md)
- Open een tabblad met <http://192.168.56.20:9000> (Portainer)

# Belangrijke vaardigheden

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
