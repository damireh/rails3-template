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

git add: '.'
git commit: "-am 'installed devise and cancan, generated user model and devise views'"

generate 'migration add_username_to_users username:string'
run 'rake db:migrate'
copy_static_file "app/models/user.rb"
copy_static_file "config/initializers/devise.rb"
copy_static_file "config/locales/en.yml"

git add: '.'
git commit: "-am 'allow users to sign in using their email or username'"
