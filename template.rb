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
puts "Creating rvmrc with default ruby using gemset #{app_name}".black_on_green
create_file '.rvmrc', 'rvm gemset default@#{app_name}'

# remove rails default files
puts "Removing rails default files".white_on_red
remove_file 'public/index.html'
remove_file 'app/assets/images/rails.png'
