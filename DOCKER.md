# Docker

You can use docker to run the three applications which make up the Mentor-Mentee App on your local machine. We use docker compose to create three containers running: 

1. The front end using react
1. The back end using rails 
1. A Postgres database. 

## Installing Docker

[Click here to look up how to install docker on your operating system](https://docs.docker.com/engine/install/)

## Using Docker

Create containers in detached mode so you get the cursor back. 
```
docker-compose up -d
```

Once you have spun up your containers you can view the websites of the front end and back end on:

* Front end: http://localhost:80
* Back end: http://localhost:3000
* Swagger docs for back end: http://localhost:3000/api-docs/index.html

When you are finished you can remove the containers. Including the `-v` also removes the data from the database. You could add server to the end of the command below to only down that container. 

```
docker-compose down -v
```

## Accessing the Command Line of your Containers

Say you just used the standard docker-compose up command, you can use the following commands to enter into the command line of each of the three containers which are now runing. 

```
docker container exec -it my-app bin/sh

docker container exec -it server bash

docker container exec -it postgres bash
```

### Postgres
Once in the command line for postgres, navigating postgres is a bit tricky, the following are helpful commands to find a particular table in the postges database. 

What I want... | I do it with... 
-------------- | --------------- 
Go to the mentormentee database | `psql -U mentoruser mentormentee` 
List databases | `\l` 
List tables | `\dt` 
Select all items from `api_user` table (could be any table, you found names using `\dt`).<br>***Don't forget the ;*** | `SELECT * FROM api_users;` 
Quit psql | `\q` 

## Useful Commands for Degugging

> :memo: When I use the word `server` below, that is just the name of the container with the server running on it, you could substitute in the words `my-app` for the front end or `postgres` for the database)

If *&lt;problem>* | I can run *&lt;command>* | So that I can *&lt;achieve something>*
-------------- | --------------- | ----
there is an issue in only one of the apps | `docker-compose up -d server` | start only the problematic app and debug and fix it in isolation
I don't know what the issue is | `docker-compose logs server` | view the logs of a particular container
your changes are not taking affect | `docker-compose up --build server` | rebuild the image
&nbsp; | `docker-compose build --no-cache server` | get rid of the image cache and start from scratch when building the image
a container is failing at some point, or exiting randomly | `docker-compose run server /bin/sh` | bring up the command line of this newly created container


## Reminders

1. You can only run one CMD command in your Dockerfile, if you need more commands you need to put them in a bash script, don't forget to add shebang and make it executable
I made `init_script.sh` executable by running. This is part of the repo and you don't need to redo this. 
    ```
    chmod u+x init_script.sh
    ```

