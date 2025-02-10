# Docker Hub Homework

## Посилання на docker hub https://hub.docker.com/u/gimalaj

## Створення та налаштування Docker Hub

```sh
mkdir HW4-docker-hub
cd HW4-docker-hub/
touch Dockerfile
mcedit Dockerfile 
cp ../HW3-dockerfile/index.html ../HW4-docker-hub
mcedit index.html 
```

## Створення неоптимізованого образу

```sh
sudo docker build -t my-unoptimize-image .
sudo docker images 
```

## Авторизація та завантаження неоптимізованого образу в docker hub
```sh
sudo docker login -u gimalaj
sudo docker tag my-unoptimize-image gimalaj/my-unoptimize-image:0.1
sudo docker images
sudo docker push gimalaj/my-unoptimize-image:0.1
```

## Оптимізація та завантаження нового образу в docker hub

```sh
mcedit Dockerfile-1 
sudo docker build -t my-optimized-image -f ./Dockerfile-1 .
sudo docker images
sudo docker tag my-optimized-image gimalaj/my-optimized-image:0.2
sudo docker push gimalaj/my-optimized-image:0.2
```

## Видалення локальних образів 
```sh
sudo docker rmi my-optimized-image my-unoptimize-image
sudo docker images
```
```
REPOSITORY                    TAG       IMAGE ID       CREATED              SIZE
gimalaj/my-optimized-image    0.2       b6a28a592871   About a minute ago   202MB
gimalaj/my-unoptimize-image   0.1       412325da7810   8 minutes ago        205MB
```


# Docker Container Management

## Видалення старих образів

```sh
gimalaj@ubuntu:~/docker/HW4-docker-hub$ sudo docker rmi gimalaj/my-optimized-image:0.2 gimalaj/my-unoptimize-image:0.1
```
**Вивід:**
```
Untagged: gimalaj/my-optimized-image:0.2
Untagged: gimalaj/my-optimized-image@sha256:a60997a694628411978be852939a7f9ce9a0bc8e145eb727c276a2146e20495f
Deleted: sha256:b6a28a5928714ca18a647efaf9cbff8d6a8a85babe111cc1bdad2cde15a21ebb
Untagged: gimalaj/my-unoptimize-image:0.1
Untagged: gimalaj/my-unoptimize-image@sha256:7d578b3b70b1ee0fba6d9e4275adcb2c23f26fde6399696d7237bbee40d4c4cd
Deleted: sha256:412325da781008127a9cbad3f481d022112dac0e6a95b2b69c981ff721ea2456
```

## Перевірка доступних образів

```sh
sudo docker images
```
**Вивід:**
```
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hw3-docker    latest    67dd050b1e8b   5 days ago    197MB
hello-world   latest    f1f77a0f96b7   2 weeks ago   5.2kB
```

## Запуск контейнера з оптимізованим образом

```sh
sudo docker run -d -p 80:80 gimalaj/my-optimized-image:0.2
```

**Вивід:**
```
Unable to find image 'gimalaj/my-optimized-image:0.2' locally
0.2: Pulling from gimalaj/my-optimized-image
...
Status: Downloaded newer image for gimalaj/my-optimized-image:0.2
29391cb50d4428820e3c23119ad37b8dae054a3d0a05c9eab4bb7c2bcc16c86c
```

## Перевірка запущених контейнерів

```sh
sudo docker ps
```
**Вивід:**
```
CONTAINER ID   IMAGE                            COMMAND                  CREATED          STATUS          PORTS                               NAMES
29391cb50d44   gimalaj/my-optimized-image:0.2   "nginx -g 'daemon of…"   13 seconds ago   Up 12 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   nifty_newton
```

## Запуск контейнера з неоптимізованим образом

```sh
sudo docker run -d -p 81:80 gimalaj/my-unoptimize-image:0.1
```

**Вивід:**
```
Unable to find image 'gimalaj/my-unoptimize-image:0.1' locally
0.1: Pulling from gimalaj/my-unoptimize-image
...
Status: Downloaded newer image for gimalaj/my-unoptimize-image:0.1
2866c998b8ef5bccf4e9c25c18ac838429306c58994334db0c2e3890646d7d06
```

## Перевірка запущених контейнерів

```sh
sudo docker ps
```
**Вивід:**
```
CONTAINER ID   IMAGE                             COMMAND                  CREATED          STATUS          PORTS                                 NAMES
2866c998b8ef   gimalaj/my-unoptimize-image:0.1   "nginx -g 'daemon of…"   4 seconds ago    Up 3 seconds    0.0.0.0:81->80/tcp, [::]:81->80/tcp   naughty_yonath
29391cb50d44   gimalaj/my-optimized-image:0.2    "nginx -g 'daemon of…"   48 seconds ago   Up 47 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp     nifty_newton
```

## Перевірка доступних образів після запуску контейнерів

```sh
sudo docker images
```
**Вивід:**
```
REPOSITORY                    TAG       IMAGE ID       CREATED          SIZE
gimalaj/my-optimized-image    0.2       b6a28a592871   46 minutes ago   202MB
gimalaj/my-unoptimize-image   0.1       412325da7810   53 minutes ago   205MB
hw3-docker                    latest    67dd050b1e8b   5 days ago       197MB
hello-world                   latest    f1f77a0f96b7   2 weeks ago      5.2kB
