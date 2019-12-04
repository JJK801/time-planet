# README

## Intro

Time for the Planet is a website to help raise money and find entrepreneurs to create companies dedicated to fight climate change.

Purchasing shares is done using a [Typeform](https://www.typeform.com/), whose link is found on [this page](https://www.time-planet.com/devenir-associee).

Projets content is controlled by editors via a CMS.

Check the website : https://www.time-planet.com

## Technical stack

Mon CDI is developped using Ruby on Rails. 

For JavaScript, it uses the framework [Stimulus](https://stimulusjs.org/).

Editor can publish new projects using the CMS [Prismic](http://prismic.io/).

A continuous integration system is set up using [Circle CI](https://circleci.com/) to launch tests from Github. The website is deployed through [Heroku](https://heroku.com). Errors are catched with [Sentry](https://sentry.io).

[Sidekiq](https://github.com/mperham/sidekiq) is used for background processing. 

## Style

This website uses only the grid system of [Bootstrap](https://getbootstrap.com/)

## Install project

### Clone the repository

``` 
git clone git@github.com:EmmanuelleN/time-planet.git
cd mon-time-planet
```
### Check you Ruby version

```
ruby -v
``` 

The ouput should start with something like ruby 2.6.5

If not, install the right ruby version using rbenv (it could take a while):

```
rbenv install 2.6.5
```

### Install dependencies

Using Bundler and Yarn:

```
bundle && yarn
```
### Environment variables

The environment variables are set using the [dotenv](https://github.com/bkeepers/dotenv) gem. To get the variables, contact the developper at emmanuelle@nada.computer (sensitive data).

### Initialize the database

```
rails db:create db:migrate db:seed
``` 

### Add Heroku remote

Using the command line:

``` 
heroku git:remote -a time-planet
```

## Serve

Start rails server :
```
rails s
``` 

Start sidekiq to enable background processing
```
sidekiq
```


## Deploy

Deploy to production :

```
git push heroku master
```


> Be careful when deploying, always add new environment variables to Heroku before deploying, and migrate the database and restart > the server after deploying if needed.
