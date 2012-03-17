# setup git
puts "Setting up Git".white_on_magenta
git :init
git add: '.'
git commit: "-am 'initial commit'"
