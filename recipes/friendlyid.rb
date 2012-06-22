puts "Installing FriendlyId".white_on_blue
generate 'migration add_slug_to_users slug:uniq'
run 'rake db:migrate'
