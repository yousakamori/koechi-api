source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'bcrypt'
gem 'bootsnap', require: false
gem 'pg'
gem 'puma'
gem 'rack-cors'
gem 'rails', '7.0.2.4'
gem 'rails-i18n'
gem 'redis-rails'

# pagenation
gem 'kaminari'

# s3
gem 'aws-sdk-s3', require: false

# mail
gem 'sendgrid-ruby'

# image
gem 'active_storage_validations'
gem 'image_processing'
gem 'mini_magick'

# いい感じのcounter_cache
gem 'counter_culture'

# input urlをlinkへ変換
gem 'rinku'

# sort
gem 'order_as_specified'

# authorize
gem 'pundit'

# emoji
gem 'emoji_regex'

# search
gem 'ransack'

gem 'jbuilder'

group :development, :test do
  # repl
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-byebug'
  gem 'pry-rails'

  # test
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'

  # N + 1
  gem 'bullet'
end

group :development do
  gem 'listen'
  gem 'spring'

  # deploy
  gem 'capistrano', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false

  # rubocop
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
