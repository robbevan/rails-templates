def javascripts
  if File.exists?('public/javascripts/jquery.js')
    %q{<%= javascript_include_tag 'jquery.js' %>
    <%= javascript_include_tag 'application' %>}
  else
    "<%= javascript_include_tag :defaults %>"
  end
end

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