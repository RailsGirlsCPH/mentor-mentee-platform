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

A local SQLite database is provided as standard. However instead of individual local databases we plan to use a shared PostgreSQL database on a server. 

Please note that the PostgreSQL 'pg' gem which has been added to the Gemfile will cause your bundler to error unless you have installed PostgreSQL on your machine. On Mac OS this is done by simply entering the following command.  

```
brew update
brew install postgresql
```

Once you do this you should be able to `bundle install` without any issues. 

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
