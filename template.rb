# create rvmrc
create_file '.rvmrc', 'rvm gemset 1.9.3-p125@#{app_name}'

# remove rails default files
remove_file 'public/index.html'
remove_file 'app/assets/images/rails.png'

# add most used gems
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
empty_directory 'test'

create_file 'test/minitest_helper.rb' do
  %{
    ENV['RAILS_ENV'] = 'test'
    require File.expand_path('../../config/environment', __FILE__)
    require 'minitest/autorun'

    Turn.config.format = :cue
  }
end

create_file 'lib/tasks/minitest.rake' do
  %{
    require 'rake/testtask'

    Rake::TestTask.new(:test => 'db:test:prepare') do |t|
      t.libs << 'test'
      t.pattern = 'test/**/*_test.rb'
    end
  }
end

append_to_file 'Rakefile' do
  %{

    namespace :spec do
      task :statsetup do
        ::STATS_DIRECTORIES << ['Unit tests',  'test/models']
      end
    end

    task :stats => 'spec:statsetup'
  }
end

# setup git
git :init
git :add => '.'
git :commit => "-am 'initial commit'"

# setup devise and cancan
generate 'devise:install'
generate 'devise User'
generate 'devise:views'
generate 'cancan:ability'
rake 'db:migrate'

git :add => '.'
git :commit => "-am 'installed devise and cancan, generated user model and devise views'"
