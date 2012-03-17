# add basic welcome page and set it as root
generate "controller", "welcome index"
route("root to: 'welcome#index'")

git add: '.'
git commit: "-am 'generated welcome controller and set root route to index action'"
