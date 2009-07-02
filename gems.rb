# install gems
gem 'mislav-will_paginate', :version => '~> 2.3.8', :lib => 'will_paginate',  :source => 'http://gems.github.com'

# append TODO
open('README.md', 'a') { |f|
  f.puts "Run 'rake gems:unpack' to Freeze gems under vendor/gems"
}

# append require
open('config/initializers/requires.rb', 'a') { |f|
  f.puts "require 'will_paginate'"
}