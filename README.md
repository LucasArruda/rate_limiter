# Rate Limiter

Rate Limiter is a rails module that can easily limit requests per client for all endpoints or for specific ones.

To add it, all you have to do is `include RateLimit` in ApplicationController to have it on all your controllers using default settings of 100 request per hour (3600 seconds).

You can also add it directly to the controller you want to be rate limited.

To customize, just use helper methods `rate` and `period`, as following:

```ruby
class AnImportantController < ApplicationController
  include RateLimit

  # those are the default (optional declaration)
  rate 100 # one hundred request
  period 3600 # one hour

  …
end
```

How to run
---

Easy run with docker (recommended) or run directly in the system.

## Running in the system

Download rvm
```sh
\curl -sSL https://get.rvm.io | bash -s stable --rails
```

Install ruby 2.6.5
```sh
rvm install 2.6.5
```

Install rails
```sh
gem install rails
```

Bundle
```sh
bundle install
```

Have PostgreSQL installed (binaries available on: https://www.postgresql.org/download/)

Set credentials
```sh
mv config/database.yml config/database.yml.bak
mv config/database.pg.yml config/database.yml
```

Fill specific DB settings like PG user/role, port and address, if you don't have the typical defaults.

Setup the database
```sh
rails db:create
```


### Executing

Run the project with 

```sh
rails s
```

Open [localhost:3000/low_rate/index](localhost:3000/low_rate/index) and refresh twice to see yourself blocked.

#### Running specs

Simply run 
```sh 
rails t
```


## Running in docker

### Have docker desktop installed

#### Windows
https://hub.docker.com/?overlay=onboarding

#### Mac
https://hub.docker.com/?overlay=onboarding

#### Linux & other systems

https://docs.docker.com/compose/install/

### Executing

Run the commands:
```sh
docker-compose build
docker-compose up
```

In another terminal, run:
```sh
docker-compose run web rails db:create
```

Open [localhost:3000/low_rate/index](localhost:3000/low_rate/index) and refresh twice to see yourself blocked.

#### Running specs

While server is up (`docker-compose up`), run:

```sh
docker-compose run web rails t
```
