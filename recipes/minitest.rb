# setup test environment
puts "Seting up test environment".white_on_magenta
generate 'mini_test:install'
empty_directory 'test/models'
empty_directory 'test/acceptance'

append_to_file 'Rakefile' do
  %{namespace :spec do
  task :statsetup do
    ::STATS_DIRECTORIES << ['Unit Tests',  'test/models']
    ::STATS_DIRECTORIES << ['Acceptance Tests',  'test/acceptance']
  end
end

task stats: 'spec:statsetup'}
end

git add: '.'
git commit: "-am 'setup test environment'"
