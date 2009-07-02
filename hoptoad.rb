plugin 'hoptoad_notifier', :git => "git://github.com/thoughtbot/hoptoad_notifier.git", :submodule => true

file 'config/initializers/hoptoad.rb',
%q{HoptoadNotifier.configure do |config|
  config.api_key = 'API_KEY'
end}

open('README.md', 'a') { |f|
  f.puts "Replace 'API_KEY' in config/initializers/hoptoad.rb and run 'rake hoptoad:test'"
}