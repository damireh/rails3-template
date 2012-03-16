# check prerequisites
%w{colored bundler}.each do |gem|
  unless Gem::Specification.find_all_by_name(gem).any?
    run "gem install #{gem}"
    Gem.refresh
    Gem::Specification.find_by_name(gem).activate
  end
end

require "colored"
require "bundler"

# create rvmrc
puts "Setting up RVM gemset and Ruby version".black_on_magenta

# strip colors in case rvm_pretty_print_flag is enabled
rvm_list = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), '')

current_ruby = rvm_list.match(/=\*\ ([^ ]+)/)[1]
ruby = ask "Which RVM Ruby would you like to use? [#{current_ruby}]".black_on_white
ruby = current_ruby if ruby.blank?

gemset = ask "What would you like to name the custom gemset? [#{@app_name}]".black_on_white
gemset = @app_name if gemset.blank?

# create the gemset
run "rvm #{ruby} gemset create #{gemset}"

# create rvmrc and mark it as trusted
create_file ".rvmrc", "rvm use #{ruby}@#{gemset}"
run "rvm rvmrc trust #{app_path}"

# remove rails default files
puts "Removing rails default files".white_on_red
remove_file 'public/index.html'
remove_file 'app/assets/images/rails.png'

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

# setup test environment
puts "Seting up test environment".white_on_magenta
empty_directory 'test'

create_file 'test/minitest_helper.rb' do
  %{ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'

Turn.config.format = :cue}
end

rakefile 'minitest.rake' do
  %{require 'rake/testtask'

Rake::TestTask.new(:test => 'db:test:prepare') do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end}
end

append_to_file 'Rakefile' do 
  %{namespace :spec do
  task :statsetup do
    ::STATS_DIRECTORIES << ['Unit tests',  'test/models']
  end
end

task :stats => 'spec:statsetup'}
end

# setup git
puts "Setting up Git".white_on_magenta
git :init
git :add => '.'
git :commit => "-am 'initial commit'"

# setup devise and cancan
puts "Installing Devise".white_on_blue
generate 'devise:install'
puts "Generating Devise User model".black_on_yellow
generate 'devise User'
puts "Generating Devise views".black_on_yellow
generate 'devise:views'
puts "Installing CanCan".white_on_blue
generate 'cancan:ability'
rake 'db:migrate'

git :add => '.'
git :commit => "-am 'installed devise and cancan, generated user model and devise views'"
