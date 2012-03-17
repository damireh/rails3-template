puts "Installing FriendlyId".white_on_blue
generate 'migration add_slug_to_users slug:string'
# TODO: add unique index on slug
run 'rake db:migrate'
