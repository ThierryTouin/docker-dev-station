
## Prepare environnement 

- Create developpement network

```
.createNetwork.sh
```

- Set source code directory

  + Rename the file *env_template* in .env
  + Set **sources_directory** variable with your source code directory

## Starting developpement environnement

```
.startENV_RM.sh
.startENV_Liferay.sh
.startENV_WordPress.sh
.startENV_Ionic.sh
```

## Entrer dans le container


- Set environnemet image

  + For Java
```
source ./setEnv.sh java
```

  + For Ionic
```
source ./setEnv.sh ionic
```

- Entrer 

```
.shell.sh

or 

sudo docker container exec -it docker_dev-app_1 bash
sudo docker container exec -it --user root docker_dev-app_1 bash


```








## En cas de conflit,

```
sudo docker ps -a
sudo docker rm ...
```

## In container Java image
- You can use the following command to switch java version
```
sudo update-alternatives --config java
```


### Extraire un contenu d'un container
```
docker cp <containerId>:/file/path/within/container /host/path/target
```


### Network
```
netstat -an
```
