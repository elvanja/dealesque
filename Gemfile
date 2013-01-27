source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'haml-rails'
gem 'dalli'
gem 'thin'

# Amazon Product Advertising API support
gem 'vacuum'
gem 'roar'
gem 'roar-rails'
gem 'virtus'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem 'twitter-bootstrap-rails'
end

group :development, :test do
  gem 'therubyracer', :platforms => :ruby # https://devcenter.heroku.com/articles/rails3x-asset-pipeline-cedar
  gem 'rspec-rails'
  gem 'rspec-given'
  gem 'json_spec'
  gem 'vcr'
  gem 'surrogate'
end

group :development do
  gem 'ci_reporter'
  gem 'simplecov'
  gem 'simplecov-rcov'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'sextant'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
