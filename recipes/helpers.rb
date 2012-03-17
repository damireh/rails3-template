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
copy_static_file "app/views/shared/_alert.html.erb"
copy_static_file "app/views/shared/_form_error_messages.html.erb"
