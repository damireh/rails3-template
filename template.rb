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

# Directories for template partials and static files
@template_root = File.expand_path(File.join(File.dirname(__FILE__)))
@partials     = File.join(@template_root, 'partials')
@static_files = File.join(@template_root, 'files')

# copy a static file from the template into the new application
def copy_static_file(path)
  remove_file path
  create_file path, File.read(File.join(@static_files, path))
end

apply "#{@partials}/_rvm.rb"

# remove rails default files
puts "Removing rails default files".white_on_red
remove_file 'public/index.html'
remove_file 'app/assets/images/rails.png'

apply "#{@partials}/_bootstrap.rb"
apply "#{@partials}/_gems.rb"


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
