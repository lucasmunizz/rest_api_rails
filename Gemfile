# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
gem 'bootsnap', require: false
gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.3'
  gem 'rubocop', '~> 1.57'
end

group :development do
end
