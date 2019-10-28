# Rails App for Mentor and Mentee Platform 

A simple web app looking for mentor who shares knowledge and skills to help mentees get better at coding 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

In order to install this app it is necessary to have - Ruby Version 2.6.2 and Rails 5.2

To check what versions you have on your local system you can run the following commands. 

```
ruby -v
rails -v
```

You can also check which version of ruby you are currently using

```
which ruby
```
If you are using ruby which comes installed on the system this can be a problem. You would like to be using a version of ruby controlled by a ruby version manager.  

If you are using a version of ruby controlled by a ruby version manager you will get output which mentions the ruby manager in the path as seen below. 

```
~/.rvm/rubies/ruby-2.6.2/bin/ruby
```

If you do not have the required versions of rails and ruby, or do not have a ruby version manger you can follow the steps below.  

As a first step install a ruby version manager. There are three available; RBENV, RMV and CHRUBY.
Below are links detailing how to set up a version manager in terminal. 
- RBENV: https://devhints.io/rbenv
- RMV: https://rvm.io

After installing version manager you can use the version manager to install the version of ruby you need. Use the command below for the manager you are using. 

```
rvm install 2.6.2
```
or 
```
rbenv install 2.6.2
```

Note you may need to specify which version of ruby you want to use the next time you log into your machine. You always check which ruby is being used currently, and instruct a particular version to be used for your session if it does not automatically point to the right one (2.6.2).  

```
rvm use ruby-2.6.2
```
or 

```
rbenv local 2.6.2
```

Now you can install rails and bundler. 

```
gem install bundler 
gem install rails
```

### Project codebase.

Download the mentor-mentee-platform code held in the GitHub Repository. 

```
git clone https://github.com/RailsGirlsCPH/mentor-mentee-platform.git
```

Go to the new mentor-mentee-platform folder created on your system, there are two folders within there, one for the server, and another for the client. To work on the server go to the server folder and from within there run the following commands. 

```
$bundle install
$bundle exec rails server

```
The output from the last command launches a local web page you can interact with. The address is given in the output. 

### PostgresSQL

!!Do not follow this section until review complete!!

A local SQLite database is provided as standard when you set up a Ruby on Rails app. However we plan to use PostgreSQL as our database instead. 

Unlike SQLite, which can run within the Rails app, PostgreSQL runs as a server which the Rails app must to connect to. 

Below are instructions to set up a local version of a PostgreSQL server on your own machine. Once this server has been started it can be queried by the Rails app. 

Link to PostgreSQL Docs: https://www.postgresql.org/docs

<details>
<summary>Install PostgreSQL</summary>
<br>

There are many apps which you can use to install and handle PostgreSQL.  Examples are Postgres.app, Postico and pgAdmin. 
I installed PostgreSQL via the command line but we may change this section if people find it easier to to use an app. 

#Installation via command line (Mac OS):

Entering the following command:  

```
brew update
brew install postgresql
```

It is possible to initiate the database via the following command. 

```
initdb /usr/local/var/postgres
```

I found this link useful, https://www.robinwieruch.de/postgres-sql-macos-setup. 
Note that we do not want to set up the database as shown in this link, instead we would like the rails server to set up the database the first time we run the rake db:setup command. 

</details>

<details>
<summary>The PSQL Command Line</summary>
<br>
  
Commands used to stop and start the PostgrSQL server.  
```
pg_ctl -D /usr/local/var/postgres start -l logfile

pg_ctl -D /usr/local/var/postgres stop
```
Adding the logging flag means that wherever folder you start the server in, a log file will be created. 
For this reason it is easiest to start the server within your project's working directory, otherwise you will create log files all over your machine which you will need to clean up. 

</details>

<details>
<summary>Create User</summary>
<br>
Although we will not create a database from the psql command line we would like to set up a user with a password. 
We can store the username and password in the rails app so that it can use these credentials to access the server. 

https://www.digitalocean.com/community/tutorials/how-to-set-up-ruby-on-rails-with-postgres
  ...continue.....
</details>

<details>
<summary>PostgreSQL Gem</summary>
<br>

The PostgreSQL 'pg' gem has been added to the Gemfile.  

</details>

<details>
<summary>Setting up Rails Database</summary>
<br>
  
Now that you have a PostgreSQL server set up we need to update your rails app so that it queries this database, and has the credentials needed to create databases, and read and write to the database. 

This article has useful information regarding setting up a rails with PostgreSQL: https://medium.com/@noordean/setting-up-postgresql-with-rails-application-357fe5e9c28
  
The first step should be removing the SQLite databases (/server/db/\*.sqlite) from your working directory. This will not happen automatically.   

You will need to create a .env file in the server folder which contains the information that the rails server will need in order to access the PostgreSQL database. 

```
POSTGRES_USER=''
POSTGRES_PASSWORD=''
POSTGRES_HOST='localhost'
POSTGRES_DB='your_database_name'
POSTGRES_TEST_DB='your_database_name_test'
```

The hidden files of a directory can be viewed in BASH using 

```
ls -a
```

Note that this .env file should not pushed to the server as it will contain the password to your local PostgreSQL database. 

Therefore we have created a version of the .env file called .env.template which is a copy of the .env file without any actual passwords or database names. 

```
dotenv -t .env
```

This can be pushed to the remote repository instead. This file has already been created and is part of the master branch. 

We also included the .env file in the .gitignore file held on the root directory of the project. If you have this version of .gitignore in your working directory then when you use. More information about dotenv can be found here: https://github.com/bkeepers/dotenv 

```
git add . 
```

 the .env file will be ignored. 

Once the .env file is in place and the PostgreSQL server has been started then the command 

```
rake db:setup
```

will lead to the new databases being created. 

</details>

<details>
<summary>Running Servers & Checking Functionality</summary>
<br>
To do
</details>

## Keeping up-to-date: Dependabot

Depandabot has been installed on the Server directory https://dependabot.com/#how-it-works 

This bot reviews the Gem's listed in our Gemfile as well as additional depencies listed in packages.json. If there are out of date or insecure dependencies Dependabot will create a pull request to update each individual dependency. Dependabot provides a backward compatibility score with each proposed update. 

At the moment there is a limit to how many updates the Dependabot will recommend a day, so that we don't get spammed with pull requests. We need to incorporate some kind of testing to this update process. Dependabot just makes us aware the updates are available, we need to test to make sure the update is compatible with our codebase. Please see below. 

## Running the tests

You can write tests, to be run using RSpec, which test the behaviour of APIs for various resources. 
You can check the output of these tests on your machine by running the following command. 

```
bundle exec rspec spec
```

The command above runs all of the tests created in the spec files of your current directory. If you only want to review the tests of one spec file you can run. 

```
bundle exec rspec spec/requests/api/version/name_of_resource_spec.rb
```

More information can be found here https://rspec.info 

It is possible to set up an automated system so that when someone makes a pull request, or tries to merge to a branch, all tests are run automatically. A tool like Travis-CI can be used to do this. This has not been set up yet. 

If you have been making changes to your database, and find that the tests are producing errors which suggests the database in your test environment does not reflect what you have in development you can inspect the database by 

```
sqlite3 db/test.sqlite3
```

If the contents of the database is not correct you can remove the test database and create it again by running the database migrations stored in server/db. 

```
rm db/test.sqlite3
bundle exec rake db:create db:migrate RAILS_ENV=test
bundle exec rspec spec
```
<details>
<summary>Inspect Faker</summary>
<br>

When running your spec tests you will use data created for the tests using the Faker Library.

Link: https://github.com/faker-ruby 

You may wish to inspect the test data which is being created by your spec files.

To do this interactively you can run Faker create commands in the rails console. 

On the command line: 
```
rails console
```

Within the interactive rails console run the following commands so you can use the same syntax as you do in the *_spec.rb* files

```
require 'factory_bot'
require 'faker'
FactoryBot.find_definitions
include FactoryBot::Syntax::Methods
```

Then you can create some data. Two examples are shown below:

```
user_list = create_list(:api_user, 5)
wish1=create(:wish, api_user_id: users_list.first.id)
user_list.first.wishes.first
```

Note if you make changes to your files you need to reload the rails console for them to take effect. 

</details>

## Coding Style

### Quote Style

.JSON files use Double Quotes. 

.rb files (ruby files) use Single Quotes, except in the case that you would like to use string interpolation. 

This is when you would like to substitute some information into a string. 

```
"/api/v1/api_users/#{api_user_id}/"
```

is not equivalent to 

```
'/api/v1/api_users/#{api_user_id}/'
```

The substitution of #{api_user_id} will only work with double quotes in ruby files. 

Further information can be found at: http://ruby-for-beginners.rubymonstas.org/bonus/string_interpolation.html

## Deployment


## Built With

* [ruby on rails](https://rubyonrails.org/) - The web framework used


## Contributing

Please read for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
