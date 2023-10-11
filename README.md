# BASES_P2_202109567
## Start project

## Start docker image of mysql
```
# command to run the docker image of mysql
$ docker run --name mysql-server -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -d mysql
# start the docker image of mysql
$ docker start mysql-server
```

## Give access
```
$ docker exec -it <CONTAINER_ID>  mysql -uroot -p
mysql> CREATE USER 'nilu'@'172.17.0.1' IDENTIFIED BY 'password';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'nilu'@'172.17.0.1' WITH GRANT OPTION;
mysql> flush privileges;
mysql> exit 
```


## Repositories
https://github.com/Jodyannre/conferenciaBases1/tree/main/mysql/db
https://github.com/edinfusion/LAB_BD1_2S2023