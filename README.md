# README

* Hosted with dokku
* URL: https://travel-range.dev.fiwares.com
* URL with params: https://travel-range.dev.fiwares.com/cities?lat=48.08&lon=-1.68&radius=600
* URL with params (JSON) https://travel-range.dev.fiwares.com/cities.json?lat=48.08&lon=-1.68&radius=600

## Requirements
* Ruby 3.0.1
* Rails 6.1.3.1

## Prepare
In development, the database is sqlite, but postgresql on production

```
bundle install
yarn install

rake db:prepare
rake db:seed
```

## Run
```
rails s # http://localhost:3000
```

## Test
```
rails test:all
```
