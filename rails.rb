# Based on: http://blog.airbladesoftware.com/2009/4/28/how-to-vendor-rails

# add Rails as submodule
run "git submodule add git://github.com/rails/rails.git vendor/rails"

# append TODO
open('README.md', 'a') { |f|
  f.puts "Switch from Edge Rails to 2.3 stable by running: 'cd vendor/rails/ && git checkout origin/2-3-stable'"
}