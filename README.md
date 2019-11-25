# Rate Limiter

Easy run with docker (recommended) or run directly in the system.

## Running in the system

Download rvm
`\curl -sSL https://get.rvm.io | bash -s stable --rails`

Install ruby 2.6.5
`rvm install 2.6.5`

Install rails
`gem install rails`

Bundle
`bundle install`

Have PostgreSQL installed (binaries available on: https://www.postgresql.org/download/)

Set credentials
```
mv config/database.yml config/database.yml.bak
mv config/database.pg.yml config/database.yml
```

Fill specific DB settings like PG user/role, port and address, if you don't have the typical defaults.

Configure database
`rails db:create`


### Executing

Run the project with `rails s`

Open [localhost:3000/low_rate/index](localhost:3000/low_rate/index) and refresh twice to see yourself blocked.

#### Running specs

Simply run `rails t`


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
```
docker-compose build
docker-compose up
```

In another terminal, run:
```
docker-compose run web rails db:create
```

Open [localhost:3000/low_rate/index](localhost:3000/low_rate/index) and refresh twice to see yourself blocked.

#### Running specs

While server is up (`docker-compose up`), run:

```
docker-compose run web rails t
```
