def javascripts
  if File.exists?('public/javascripts/jquery.js')
    %q{<%= javascript_include_tag 'jquery.js' %>
    <%= javascript_include_tag 'application' %>}
  else
    "<%= javascript_include_tag :defaults %>"
  end
end

# application layout
file 'app/views/layouts/application.html.erb',
%q{<!DOCTYPE html>

<html lang="en" id="APP_NAME-app">

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><%= page_title %></title>
    <%= stylesheets %>
    javascripts
  </head>
  
  <body>

    <%= render :partial => "layouts/header" %>
    
    <%= flash_div  %>
    
    <%= render :partial => "layouts/navigation" %>

    <div class="container">

      <div id="content" class="span-24 <%= content_class %>">
        <%= yield :layout %>
      </div>
      
      <%= render :partial => "layouts/footer" %>

    </div>
    
    <% if RAILS_ENV == 'production' -%>
    <script type="text/javascript">
    // insert Google Analytics code
    </script>
    <% end -%>

  </body>
  
</html>}.gsub('APP_NAME', @app_name).gsub('javascripts', javascripts)

# application partials
file 'app/views/layouts/_footer.html.erb',
%q{<div id="footer">
</div>}

file 'app/views/layouts/_header.html.erb',
%q{<div id="header">
</div>}

file 'app/views/layouts/_navigation.html.erb',
%q{<div id="navigation">
</div>}

# admin layout
file 'app/views/layouts/admin/application.html.erb',
%q{<!DOCTYPE html>

<html lang="en" id="APP_NAME-app">

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title><%= page_title(:admin) %></title>
    <%= stylesheets(:admin) %>
    javascripts
  </head>
  
  <body>

    <%= render :partial => "layouts/header" %>
    
    <%= flash_div  %>
    
    <%= render :partial => "layouts/navigation" %>

    <div id="content" class="span-24 <%= content_class %>">
      <%= yield :layout %>
    </div>
    
    <%= render :partial => "layouts/footer" %>

  </body>
  
</html>}.gsub('javascripts', javascripts)

# admin partials
file 'app/views/layouts/admin/_footer.html.erb',
%q{<div id="footer">
  <div id="version">
    <p>
      <strong><%= APP_VERSION %> | Revision: 
      <a href="https://github.com/robbevan/APP_NAME/commit/<%= REVISION %>" rel="external"><%= REVISION[0..6] %></a></strong> | 
      <%= LAST_CHANGED_DATE %>
    </p>
  </div>
</div>}.gsub('APP_NAME', @app_name)

file 'app/views/layouts/admin/_header.html.erb',
%q{<div id="header">
</div>}

file 'app/views/layouts/admin/_navigation.html.erb',
%q{<div id="navigation">
</div>}

# admin initializer
initializer 'admin.rb',
%q{# Version
f = "#{RAILS_ROOT}/VERSION"
APP_VERSION = "Version: #{(File.exists?(f) ? File.read(f) : "1.0")}"

# Revision
f = "#{RAILS_ROOT}/REVISION"
if File.exists?(f)
  REVISION = File.read(f)
  LAST_CHANGED_DATE = "Last Modified Date: #{File.mtime(f).to_s}"
else
  REVISION = %x[git log -1 $@ | awk '/^commit/ {print}'].gsub('commit ', '').chomp
  LAST_CHANGED_DATE = 'Last Modified ' + %x[git log -1$@ | awk '/^Date:/ {print}'].chomp
end}