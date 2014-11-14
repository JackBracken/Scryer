Scryer 2.0
==========

Rails version of the Scryer FF search engine.

## Getting started

1. Use RVM to segment your gems. Otherwise, you'll just need Ruby 2.1
2. `bundle install` to get yo' gem on
2. `rake db:create db:migrate` to create db and migrate
3. `rake scryer:import` to seed the database from the DLP API
4. `rails server` and you're off

## Roadmap

* Multi-fandom support
* DLP SSO auth
* Pensieve - Chrome extension + collection endpoint for opt-in reading tracking
* Saved searches
* Percolated searches / updates
