# add twitter bootstrap and h5bp
puts "Adding Twitter Bootstrap and HTML5 Boilerplate files"
copy_static_file "vendor/assets/stylesheets/bootstrap-responsive.min.css"
copy_static_file "vendor/assets/stylesheets/bootstrap.min.css"
copy_static_file "vendor/assets/javascripts/bootstrap.min.js"
copy_static_file "vendor/assets/images/glyphicons-halflings-white.png"
copy_static_file "vendor/assets/images/glyphicons-halflings.png"
copy_static_file "app/assets/stylesheets/global.sass"

copy_static_file "public/apple-touch-icon.png"
copy_static_file "public/favicon.ico"
copy_static_file "public/humans.txt"
copy_static_file "vendor/assets/javascripts/modernizr.min.js"

inject_into_file "app/assets/stylesheets/application.css", " *= require bootstrap.min\n", before: " *= require_self"
inject_into_file "app/assets/stylesheets/application.css", " *= require bootstrap-responsive.min\n", before: " *= require_self"
inject_into_file "app/assets/javascripts/application.js", "\n//= require bootstrap.min", after: "//= require jquery_ujs"

git add: '.'
git commit: "-am 'added twitter bootstrap'"
