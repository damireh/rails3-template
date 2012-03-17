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
apply "#{@partials}/_minitest.rb"
apply "#{@partials}/_git.rb"
apply "#{@partials}/_auth.rb"
