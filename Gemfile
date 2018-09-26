source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#
## RUBY VERSION
#
ruby '2.5.1'

#
## RAILS
#
gem 'rails', '~> 5.2.1'

#
## DATABASE
#
gem 'mongoid'

#
## APP SERVER
#
gem 'puma'

#
## LIBRARIES
#
gem 'as_json_representations'
gem 'email_address'
gem 'phonelib'
gem 'pundit'
gem 'rack-cors'

#
## TOOLS & UTILITIES
#
gem 'bootsnap', require: false
gem 'factory_bot_rails'
gem 'faker'

#
## DEVELOPMENT
#
group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

#
## DEVELOPMENT & TEST
#
group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

#
## TEST
#
group :test do
  gem 'database_cleaner', require: false
  gem 'mongoid-rspec', require: false
  gem 'pundit-matchers', require: false
  gem 'rspec-rails', require: false
  gem 'simplecov', require: false
end
