# Description of the development environment

## Schema 

![Description of the development environment](./resources/Archi_Environnement_DEV.svg)

## Pincipal directories

| Directory        | Description           |
| ------------- |:-------------:|
| environnement      | It is the `docker-dev-station` |
| resources      | Schema design |
| sources | Java sample project  |

## Prepare environnement 

- Create developpement network in docker. The network name is **devnet**

```
.createNetwork.sh
```

- Set source code directory

  + Rename the file *env_template* in .env
  + Set **sources_directory** variable with your source code directory


- set env variable in .bashrc
```
echo " "
echo "##"
echo "# HACKS & TRICKS"
echo "##"
echo " "
echo "# -- Starter commands"
echo "#  dds      : Go Docker Developpement Station"
echo "#  ecmd     : cmd Docker Developpement Station"
echo "# "
echo " "
echo " "
echo " -- Information "
echo " Internal IP : `hostname -I | cut -c1-12`"
echo " "
echo "# ####################################### Enjoy ;-)"
echo " "
alias dds="cd /mnt/c/Work/devPerso/docker-dev-station"
alias ecmd="/mnt/c/Work/devPerso/docker-dev-station/environnement/ecmd.sh"
```

## Global command 

```
./ecmd.sh
```
 
``` 
################################################################
# Usage: ecmd.sh  <param>                                      #
################################################################
 
 -------------------------------------------------------------- 
 -- PARAMS (env)                                             -- 
 -------------------------------------------------------------- 
  startjc              : Start Java Environment
  stopjc               : Stop Java Environment
  injc                 : Enter in Java Container
  startwp              : Start WordPress Environment
 -------------------------------------------------------------- 
 -- PARAMS (dependencies)                                    -- 
 -------------------------------------------------------------- 
  elastic              : Start Elasticsearch server
  postgresql           : Start Postgresql server
 -------------------------------------------------------------- 
 -- PARAMS (admin)                                           -- 
 -------------------------------------------------------------- 
  admin                : Start Docker Admin UI (portainer)
  dbadmin              : Start Database Admin UI (omnidb)
  sonar                : Start Sonar Server
 -------------------------------------------------------------- 
 -- PARAMS (tool)                                            -- 
 -------------------------------------------------------------- 
  share                : start sharing files tool
 -------------------------------------------------------------- 
 -- PARAMS (script)                                          -- 
 -------------------------------------------------------------- 
  dtop                 : Command top pour docker
  status               : Display container / image status
  stopall              : Stop all container

```


## Starting developpement environnement 

### Java 
```
./ecmd.sh startjc
```

## Enter in the container

### Java 

```
./ecmd.sh injc
```


### Ionic 

```
source ./setEnv.sh ionic
./scripts/shell.sh
```

## Admin

If you want manage your docker environnement with an ihm, you can start **portainer** with the following command

```
./ecmd.sh admin
```

Open WebConsole at the address
```
http://localhost:9999
```

## DB Admin

If you want manage your database with an ihm, you can start **omnidb** with the following command

```
./ecmd.sh dbadmin
```

Open WebConsole at the address
```
http://localhost:8000
```

## Sonar

If you a **sonarquke** server, , you can start it with the following command

```
./ecmd.sh sonar
```

Please remove **sonarHTML** plugin from sonarquke backoffice

You can run a sonar client in the following directory **environnement/sonar/client**
(you must create .env file before build image)

---
# Docker command

## List containers
```
docker ps -a
```

## Delete cotainer or image
```
docker rm ...
docker rmi 
```

## Volume
```
docker volume ls
docker volume rm hello
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

### TODO
docker run -v pwd:/data -p 5000:5000 --rm sigoden/dufs /data -A
$ cat <diagram-file>.py | docker run -i --rm -v $(pwd)/out:/out diagrams:<version>


