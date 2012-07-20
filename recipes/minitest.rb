# setup test environment
puts "Seting up test environment".white_on_magenta
empty_directory 'test'

create_file 'test/minitest_helper.rb' do
  %{ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'

DatabaseCleaner.strategy = :transaction

class MiniTest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

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

git add: '.'
git commit: "-am 'setup test environment'"
