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
@recipes     = File.join(@template_root, 'recipes')
@static_files = File.join(@template_root, 'files')

# copy a static file from the template into the new application
def copy_static_file(path)
  remove_file path
  create_file path, File.read(File.join(@static_files, path))
end

apply "#{@recipes}/rvm.rb"
apply "#{@recipes}/cleanup.rb"
apply "#{@recipes}/git.rb"
apply "#{@recipes}/bootstrap.rb"
apply "#{@recipes}/gems.rb"
apply "#{@recipes}/minitest.rb"
apply "#{@recipes}/auth.rb"
apply "#{@recipes}/paperclip.rb"
apply "#{@recipes}/friendlyid.rb"
apply "#{@recipes}/pages.rb"
