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

## Keeping uptodate: Dependabot

Depandabot has been installed on the Server directory https://dependabot.com/#how-it-works 

This bot reviews the Gem's listed in our Gemfile as well as additional depencies listed in packages.json. If there are out of date or insecure dependencies Dependabot will create a pull request to update each individual dependency. Dependabot provides a backward compatibility score with each proposed update. 

At the moment there is a limit to how many updates the Dependabot will recommend a day, so that we don't get spammed with pull requests. We need to incorporate some kind of testing to this update process. Dependabot just makes us aware the updates are available, we need to test to make sure the update is compatible with our codebase. Please see below. 

## Running the tests

Explain how to run the automated tests for this system

## Deployment


## Built With

* [ruby on rails](https://rubyonrails.org/) - The web framework used


## Contributing

Please read for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
