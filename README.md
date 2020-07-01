# Description of the development environment

## Schema 

![Description of the development environment](./resources/Archi_Environnement_DEV.svg)


## Prepare environnement 

- Create developpement network in docker. The network name is **devnet**

```
.createNetwork.sh
```

- Set source code directory

  + Rename the file *env_template* in .env
  + Set **sources_directory** variable with your source code directory

## Global command (in construction)

```
./ecmd.sh
```
 
``` 
###########################
# Usage: ecmd.sh  <param> #
###########################
 
 -- PARAMS -- 
  startjc              : Start Java Environment
  stopjc               : Stop Java Environment
  injc                 : Enter in Java Container
  elastic              : Start Elasticsearch server
  admin                : Start Docker Admin UI (portainer)
  dtop                 : Command top pour docker
  status               : Display container / image status
```


## Starting developpement environnement

```
./ecmd.sh startjc
```
or
```
.startENV_RM.sh
.startENV_Liferay.sh
.startENV_WordPress.sh
.startENV_Ionic.sh
```

## Enter in the container

### Java 

```
./ecmd.sh injc
```

or


```
source ./setEnv.sh java
./scripts/shell.sh
```

### Ionic 

```
source ./setEnv.sh ionic
./scripts/shell.sh
```

## Admin

If you want manage your docker environnement with an ihm, you can start **portainer** with the following script

```
./ecmd.sh admin
```

Open WebConsole at the address
```
http://localhost:9999
```

## Sonar

Please remove **sonarHTML** plugin from sonarquke backoffice


## if problem,

```
sudo docker ps -a
sudo docker rm ...
```

## In container Java image
- You can use the following command to switch java version
```
sudo update-alternatives --config java
```


### Extract content from a container
```
docker cp <containerId>:/file/path/within/container /host/path/target
```


### Network
```
netstat -an
```


### Ionic

#### Before start ionic application

  1. Configure .env file with env_template , complete **sources_directory** and **android_directory**
  2. Start container **.startENV_Ionic.sh** and go inside container with **setEnv.sh** and **shell.sh** 
  3. Execute **installAndroid.sh** script in **/home/user1/script** (only once)

#### Start application inside the container

```
ionic serve --lab --address=0.0.0.0
```