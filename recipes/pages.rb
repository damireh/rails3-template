# add basic welcome page and set it as root
generate "controller", "welcome index"
route("root to: 'welcome#index'")
remove_file "app/assets/stylesheets/welcome.css.scss"
remove_file "app/assets/javascripts/welcome.js.coffee"
remove_file "app/helpers/welcome_helper.rb"

git add: '.'
git commit: "-am 'generated welcome controller and set root route to index action'"
