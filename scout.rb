plugin 'scout_rails_instrumentation', :git => "git://github.com/highgroove/scout_rails_instrumentation.git", :submodule => true

file 'config/scout.yml',
%q{# This is where set your Rails Instrumentation plugin id, so the instrumentation plugin 
# can identify itself to the Scout agent.
#
# * You need to supply the Rails instrumentation plugin id from your account at http://scoutapp.com
# * Typically, you will provide the plugin id for production, but not development.
#   If you want to try out instrumentation in development, you may want to install a separate
#   Rails Instrumentation plugin and use that plugin id for development, so your development metrics are
#   clearly differentiated from you production metrics.

##########################################################################
# Single-server setup (most common setup)
###########################################################################
production: # <-- REQUIRED: your Rails Instrumentation plugin id goes here
development: # <-- typically you'll leave this blank


##########################################################################
# Multi-server setup (advanced)
##########################################################################
#production:
#  server1.com: # <- your plugin id for server1 goes here
#  server2.com: # <- your plugin id for server2 goes here
#  
#  
#development: 
#  server1.com: # <- plugin id for first developer's box
#  server2.com: # <- plugin id for second developer's box}

open('README.md', 'a') { |f|
  f.puts "Add Rails Instrumentation plugin id to 'config/scout.yml'"
}