source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'

gem 'jbuilder', '~> 2.0'

# Use mysql as the database for Active Record
gem 'mysql2'

# Auth
gem 'devise'
gem 'devise-async'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Memcached for caching
gem 'dalli'

gem 'lograge' # We don't need huge multi-line messages...

# Exception Tracking
gem 'rollbar', '~> 1.2.6'

gem 'newrelic_rpm'

# Feature flagging
gem 'rollout'

# Keen.IO
gem 'keen'
gem 'em-http-request', '~> 1.0'

# Easy running
gem 'foreman'

# Use unicorn as the app server
gem 'unicorn'

# Sass/Bootstrap
gem 'sass-rails', '~> 4.0.4'
gem 'bootstrap-sass', '~> 3.3.0'
gem 'autoprefixer-rails'

# JS Libraries
gem 'jquery-rails'
gem 'bower-rails', '~> 0.9.1'
gem 'font-awesome-rails'
gem 'chosen-rails'
gem 'select2-rails'
gem 'rails-timeago', '~> 2.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# HAML support
gem 'haml-rails'
gem 'kaminari'

# ElasticSearch
gem 'elasticsearch'
#gem 'elasticsearch-model'
#gem 'elasticsearch-rails'
#gem 'elasticsearch-persistence'

# HTTP Client
gem 'faraday'
gem 'faraday_middleware'
gem 'rash'

# Profiling
gem 'rack-mini-profiler'
gem 'flamegraph'

gem 'rack-cors', :require => 'rack/cors'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test do
  gem 'minitest-rails'
  gem 'minitest-reporters', '>= 0.5.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller' # better traces for better_errors
  gem 'spring'
  gem 'bullet'
  gem 'quiet_assets'
end
