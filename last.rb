def app_name
  @root.split('/').last
end

def stylesheets
  stylesheets = 'def stylesheets(namespace=nil)'
  if File.exists?('public/stylesheets/blueprint')
    stylesheets << "\n    " + %q{styles = stylesheet_link_tag('blueprint/screen.css', :media => 'screen, projection') + "\n"
    styles << stylesheet_link_tag('blueprint/print.css', :media => 'print') + "\n"
    styles << "<!--[if IE]>\n"
    styles << "  " + stylesheet_link_tag('blueprint/ie.css', :media => 'screen, projection') + "\n"
    styles << "<![endif]-->\n"}
  end
  if File.exists?('public/stylesheets/application.css')
  stylesheets << "\n    " + %q{styles << "\n#{stylesheet_link_tag((namespace ? "#{namespace.to_s}/" : "") + 'application')}\n"
    styles << "<!--[if IE]>\n"
    styles << "  " + stylesheet_link_tag('ie.css', :media => 'screen, projection') + "\n"
    styles << "<![endif]-->\n"
    styles}
  end
  stylesheets + "\n  " + 'end'
end

# ApplicationHelper
file 'app/helpers/application_helper.rb', 
%q{module ApplicationHelper
  def page_title(namespace=nil)
    page_title = namespace ? "APP_NAME #{namespace.to_s}" : "APP_NAME"
    page_title << ": #{controller.controller_name}"
    page_title << ": #{controller.action_name}" unless controller.action_name == 'index'
    page_title
  end
  
  } + stylesheets + %q{

  def controller_javascript_include_tag
    controller_js = File.join(RAILS_ROOT, 'public', 'javascripts', "#{controller.controller_name}.js")
    javascript_include_tag controller.controller_name if File.exists?(controller_js)
  end
  
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

  def flash_div
    [:notice, :error].collect { |type| content_tag('div', flash[type], :class => "flash #{type}") if flash[type] }
  end

  def submit_name
    controller.action_name == 'new' ? "Create" : "Update"
  end
end
}.gsub('APP_NAME', app_name)

# ApplicationController
file 'app/controllers/application_controller.rb',
%q{class ApplicationController < ActionController::Base
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
end} if File.exists?('app/models/user_session.rb')

# keep empty dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")
 
# rake('db:migrate')

# rake("gems:install", :sudo => true)
# rake("gems:unpack")

# Initialize submodules
# git :submodule => "init"