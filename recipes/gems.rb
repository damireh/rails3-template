# add most used gems
puts "Installing frequently used Gems (Devise, CanCan, Thin, Debugger, Minitest)".white_on_blue
copy_static_file "Gemfile"

# bundle
run 'bundle install'
run 'bundle update'

git add: '.'
git commit: "-am 'added Devise, CanCan, Thin, Debugger and test gems'"
