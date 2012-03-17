# install paperclip and add avatar to users
puts "Installing Paperclip".white_on_blue
generate 'paperclip User avatar'

git add: '.'
git commit: "-am 'installed paperclip and added avatar to users'"
