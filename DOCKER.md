**Docker** 

You can use docker to run the three applications which make up the Mentor-Mentee App on your local machine. We use docker compose to create three containers running the following: 

1. One for the front end using react
2. One for the back end using rails 
3. A postgres data base. 

____

**Installing Docker** 

[Click here to look up how to install docker on your operating system](https://docs.docker.com/engine/install/)


____

**Using Docker**

Create containers in detached mode so you get the cursor back. 
```
docker-compose up -d
```

Once you have spun up your containers you can view the websites of the front end and back end on:

* FrontEnd: localhost:80

* BackEnd: localhost:3000

* Swagger Docs for BackEnd: http://localhost:3000/api-docs/index.html

When you are finished you can remove the containers. Including the -v also removes the data from the database. You could add server to the end of the command below to only down that container. 

```
docker-compose down -v
```
___


**Accessing the Command Line of your Containers**

Say you just used the standard docker-compose up command, you can use the following commands to enter into the command line of each of the three containers which are now runing. 

```
docker container exec -it my-app bin/sh

```
```
docker container exec -it server bash

```
```
docker container exec -it postgres bash
```

Navigating postgres is a bit tricky, the following are helpful commands to find a particular table in the postges database. 

Go to the mentormentee database
```
psql -U mentoruser mentormentee
```
List databases
```
\l
```
See tables
```
\dt
```
Select all items from api_user table (could be any table, you found names using \dt). Don't forget the ;
```
SELECT * FROM api_users;
```
Quit psql
```
\q
```
___

**Useful Commands for Degugging**

(note when I use the word server below, that is just the name of the container with the server running on it, you could sub in the words my-app or postgres)

If you are trying to debug you can also just run one of the apps with 
```
docker-compose up -d server
```
You can also use the following to view the logs of a particular container. 
```
docker-compose logs server
```
If your changes are not taking affect you can use the following to rebuild the image
```
docker-compose up --build my-app
```
You could also you the following to get rid of the image cache and start from scratch when building the image. 
```
docker-compose build --no-cache my-app
```
If your container is failing at some point and point, or exiting randomly, you can run which will bring you to the command line of this newly created container. 
```
docker-compose run server /bin/sh
```
___

**Reminders**

1. You can only run one CMD command in your Dockerfile, if you need more commands you need to put them in a bash script, don't forget to add shebang and make it execuable
I made *init_script.sh* executable by runing. This is part of the repo and you don't need to redo this. 
```
chmod u+x init_script.sh
```

