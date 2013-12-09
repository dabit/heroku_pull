# Heroku::Pull

[![Build Status](https://travis-ci.org/dabit/heroku_pull.png?branch=master)](https://travis-ci.org/dabit/heroku_pull)

Pull the Postgres database from Heroku Rails application into your local server.

## Works great with

[Heroku][1] and [Postgres.app][2]

## Installation

Add this line to your application's Gemfile:

    gem 'heroku_pull', group: :development

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heroku_pull

## Usage

Run

    $ rake heroku:pull

And this should automatically overwrite your local development database
with a snapshot of the current database of your Heroku app.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[1]: http://heroku.com
[2]: http://postgresapp.com
