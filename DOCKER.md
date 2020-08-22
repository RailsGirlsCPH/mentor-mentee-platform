#docker-compose run server /bin/bash

We are running three containers 
One for the front end using react
One for the back end using rails 
A postgres data base. 


Useful Commands 
(note when I use the word server, that is just the name of the container with the server running on it, you could sub in the words my-app or postgres)

Creates the containers in detached mode so you get the cursor back. 
```
docker-compose up -d
```
Removes the containers, also removes the volumes with the added -v. You could add server to the end to only down that container. 

```
docker-compose down -v
```
Useful When Degugging
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

Say you just used the standard docker-compose up command, you can use the following commands to enter into the command line of each of the three containers which are now runing. 

```
```
```
```
Allow you to view command line of postgres container. 
```
docker container exec -it postgres bash
```
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
Reminders. 
1. You can only run one CMD command in your Dockerfile, if you need more commands you need to put them in a bash script, don't forget to add shebang and make it execuable
I made *init_script.sh* executable by runing. This is part of the repo and you don't need to redo this. 
```
chmod u+x init_script.sh
```

You can view the websites of the front end and back end on 
Front: localhost:80
Back: localhost:300
Swagger Docs: http://localhost:3000/api-docs/index.html
