# add useful helpers
append_to_file 'app/helpers/application_helper.rb' do
  %{def nav_link_to(text, path)
  content_tag :li, class: (current_page?(path) ? "active" : nil) do
    link_to text, path
  end
end}
end

# add bootstrap themed partials
remove_file "app/views/layouts/application.html.erb"
copy_static_file "app/views/layouts/application.html.erb"
copy_static_file "app/views/layouts/_header.html.erb"
copy_static_file "app/views/layouts/_footer.html.erb"
empty_directory "app/views/shared"
copy_static_file "app/views/shared/_alerts.html.erb"
copy_static_file "app/views/shared/_form_error_messages.html.erb"

# add bootstrap themed templates
copy_static_file "lib/templates/erb/scaffold/_form.html.erb"
copy_static_file "lib/templates/erb/scaffold/index.html.erb"
copy_static_file "lib/templates/erb/scaffold/edit.html.erb"
copy_static_file "lib/templates/erb/scaffold/new.html.erb"
copy_static_file "lib/templates/erb/scaffold/show.html.erb"
