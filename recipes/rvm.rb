# create rvmrc
puts "Setting up RVM gemset and Ruby version".white_on_magenta

# strip colors in case rvm_pretty_print_flag is enabled
rvm_list = `rvm list`.gsub(Regexp.new("\e\\[.?.?.?m"), '')

current_ruby = rvm_list.match(/=\*\ ([^ ]+)/)[1]
ruby = ask "Which RVM Ruby would you like to use? [#{current_ruby}]".black_on_white
ruby = current_ruby if ruby.blank?

gemset = ask "What would you like to name the custom gemset? [#{@app_name}]".black_on_white
gemset = @app_name if gemset.blank?

# create the gemset
run "rvm #{ruby} gemset create #{gemset}"

# create rvmrc and mark it as trusted
create_file ".rvmrc", "rvm use #{ruby}@#{gemset}"
run "rvm rvmrc trust #{app_path}"
