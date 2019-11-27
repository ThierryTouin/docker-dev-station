
## To create developpement network
```
.createNetwork.sh
```

## Set environnemet image

+ For Java
```
source ./setEnv.sh java
```

+ For Ionic
```
source ./setEnv.sh ionic
```

## Set source code directory

+ Rename .env_template in .env
+ Set **sources_directory** variable with the good path


## Starting developpement environnement

```
.startRM.sh
.startLiferay.sh
.startWordPress.sh
.startIonic.sh
```



## Entrer dans le container

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
