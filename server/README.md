# Rails App for Mentor and Mentee Platform 

A simple web app looking for mentor who shares knowledge and skills to help mentees get better at coding 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

If you are a front end developer you can simply access the version of the API deployed on Heroku, rather than installing Ruby and running a version of the server locally. APIs provided below.  

[Published Swagger API docs](https://mentor-mentee-platform.herokuapp.com/api-docs/index.html).

[Access to current version of API](https://mentor-mentee-platform.herokuapp.com/api/v1/api_users/) 
There is no authorisation on this API yet so only use mock data. This URL is publically available. 

If you would like to develop the backend then the information provided below is for you. 

### Prerequisites

In order to install this app it is necessary to have - Ruby Version 2.6.5 and Rails 5.2

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
~/.rvm/rubies/ruby-2.6.5/bin/ruby
```

If you do not have the required versions of rails and ruby, or do not have a ruby version manger you can follow the steps below.  

As a first step install a ruby version manager. There are three available; RBENV, RMV and CHRUBY.
Below are links detailing how to set up a version manager in terminal. 
- RBENV: https://devhints.io/rbenv
- RMV: https://rvm.io

After installing version manager you can use the version manager to install the version of ruby you need. Use the command below for the manager you are using. 

```
rvm install 2.6.5
```
or 
```
rbenv install 2.6.5
```

Note you may need to specify which version of ruby you want to use the next time you log into your machine. You always check which ruby is being used currently, and instruct a particular version to be used for your session if it does not automatically point to the right one (2.6.5).

```
rvm use ruby-2.6.5
```
or 

```
rbenv local 2.6.5
```

Now you can install rails and bundler. 

```
gem install bundler 
gem install rails
```

(If you are using Ubuntu or Debian Linux:) Install the development package for the PostgreSQL database `libpq-dev` package using

```bash
sudo apt-get install libpq-dev
```

### Project codebase.

Download the mentor-mentee-platform code held in the GitHub Repository. 

```
git clone https://github.com/RailsGirlsCPH/mentor-mentee-platform.git
```

Go to the new mentor-mentee-platform folder created on your system, there are two folders within there, one for the server, and another for the client. To work on the server go to the server folder and from within there run the following commands. 

```
bundle install
bundle exec rails server
```

## Keeping up-to-date: Dependabot

Depandabot has been installed on the Server directory https://dependabot.com/#how-it-works 

This bot reviews the Gem's listed in our Gemfile as well as additional depencies listed in packages.json. If there are out of date or insecure dependencies Dependabot will create a pull request to update each individual dependency. Dependabot provides a backward compatibility score with each proposed update. 

At the moment there is a limit to how many updates the Dependabot will recommend a day, so that we don't get spammed with pull requests. We need to incorporate some kind of testing to this update process. Dependabot just makes us aware the updates are available, we need to test to make sure the update is compatible with our codebase. Please see below. 

## Reviewing and Testing API's

You can use swagger to test the functionality of the currently available API's. 
You can find more information on the site: https://swagger.io/solutions/api-documentation/

For Front End Users: 

For those on the front end, consult the [published Swagger API docs](https://mentor-mentee-platform.herokuapp.com/api-docs/index.html).

For Back End Users:

Run the following commands to seed the test database & start the local server: 

```
rails db:seed
bundle exec rails server
```

Once you have changed the spec files, you can update the swagger yaml by running
```
rake rswag:specs:swaggerize
```
Then visit the local swagger site http://localhost:3000/api-docs/index.html

## Database Schema

See this [overview of the database schema](https://www.lucidchart.com/documents/view/164bd2c8-40ed-4797-acd6-e7d0e0a9c0d1).

For the most up-to-date view of the database, see the db/schema.db file.  

[Update the database schema overview chart](https://www.lucidchart.com/documents/edit/164bd2c8-40ed-4797-acd6-e7d0e0a9c0d1/0_0?shared=true) using this link.

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

<details>
<summary>Inspect in console</summary>
<br>
 
To inspect behaviour you can insert 
```
require 'pry'
```

at the top of the file you want to inspect, and then insert

```
binding.pry
```

into whatever section of code you want to understand. When you call the file rails will open an interactive console where you can inspect what objects exist, what values they hold, and what methods are availalbe. 
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

Using Heroku to host production instance. 

Once logged into Heroku code can be deployed by running: 

```
git push heroku whatever_branch_I_am_on_branch:master
```
Note that you cannot push to any branch other than master on Heroku, although the branch on the local machine can be anything. 

Because our project folder contains two sub projects in different languages, deployment requires setting the folder to be deployed to production in the buildpack. 

Instructions for getting around this issue were taken from this tutorial: https://elements.heroku.com/buildpacks/techgaun/heroku-buildpack-subdir-to-root

The key commands to be executed in route directory of sub-project (in my case /server) are: 

```
heroku buildpacks:add --index 1 https://github.com/techgaun/heroku-buildpack-subdir-to-root.git --app mentor-mentee-platform
heroku config:set PROJECT_RELATIVE_PATH=packages/adminWeb --app mentor-mentee-platform
```

After you deploy the app, you need to seed the database in order for swagger docs to work. 

```
heroku run rake db:migrate
heroku run rake db:seed
```

## Built With

* [ruby on rails](https://rubyonrails.org/) - The web framework used


## Contributing

Please read for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
