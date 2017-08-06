source 'https://rubygems.org'

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'
gem 'resque', '~> 1.26.0'
gem 'resque-scheduler', '~> 4.3.0'

gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'stripe', '~> 1.55'
gem 'jwt', '~> 1.5.6'
gem 'rollbar'
gem 'geocoder'
gem 'apnotic'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'mocha'
  gem 'timecop'
  gem 'stripe-ruby-mock', '~> 2.3.1', require: 'stripe_mock'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
