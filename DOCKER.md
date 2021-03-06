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
docker container exec -it ui /bin/sh

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
I don't know what effects my changes are making | `docker-compose -f logs server` | view the logs of a particular container in real time
your changes are not taking affect | `docker-compose up --build server` | rebuild the image
I have made changes to a dockerfile but they haven't taken effect | `docker-compose build --no-cache server` | get rid of the image cache and start from scratch when building the image
a container is failing at some point, or exiting randomly | `docker-compose run server /bin/sh` | bring up the command line of this newly created container

## Pulling image from dockerhub

The images for our repo are on dockerhub. 

https://hub.docker.com/r/railsgirlscph/mentormenteeplatform-ui

https://hub.docker.com/r/railsgirlscph/mentormenteeplatform-server

When you run `docker-compose up` this command will trigger a pull from railsgirlscph on dockerhub. 

If for some reason an image is not work correctly when you run `docker-compose up` you can pull them with the following commands. 

`docker pull railsgirlscph/mentormenteeplatform-ui`

`docker pull railsgirlscph/mentormenteeplatform-server`

postgres is not included here as we haven't defined a postgres Dockerfile, we just use the standard postgres image.

You only want to build the docker images locally if you think you have made some local changes which may affect the docker image. 

## Reminders

1. You can only run one CMD command in your Dockerfile, if you need more commands you need to put them in a bash script, don't forget to add shebang and make it executable
I made `init_script.sh` executable by running. This is part of the repo and you don't need to redo this. 
    ```
    chmod u+x init_script.sh
    ```
## Known Issues 

1. It should be possible to edit files on your local machine, and see the changes replicated in the docker containers straight away. Unfortunately if you are using EMACS, the creation of temporary files eg. #App.js will cause the React App (my-app) to error and exit. You then have to restart the container that crashed to see the effects of the changes you made. 
If you would like to use EMACS to edit the files for the React App (my-app) you should disable temporarily the creation of these files using 
```
M-X Eval Expression
(setq create-lockfiles nil)
```
If you are using another editor, for example VS code, you are not affected by this issue. 
Link to bug: https://github.com/facebook/create-react-app/issues/9056
