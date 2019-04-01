## Starting developpement environnement

```
.startEnvDev.sh
```



## Entrer dans le container

```
sudo docker container exec -it docker_dev-app_1 bash
sudo docker container exec -it --user root docker_dev-app_1 bash
```



## En cas de conflit,

```
sudo docker ps -a
sudo docker rm ...
```

