# add most used gems
puts "Installing frequently used Gems (Devise, CanCan, Thin, Debugger, Minitest)".white_on_blue
gem 'thin'
gem 'devise'
gem 'cancan'

gem_group :development do
  gem 'wirb'

  # debugger
  # see https://gist.github.com/1333785
  gem 'linecache19', '0.5.13'
  gem 'ruby-debug-base19', '0.11.26'
  gem 'ruby-debug19', :require => 'ruby-debug'
end

gem_group :test do
  gem 'factory_girl_rails'
  gem 'minitest'
  gem 'turn'
end

# bundle
run 'bundle install'
