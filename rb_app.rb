optional_templates = [
  ["blueprint",  "Add Blueprint CSS framework?"],
  ["stylesheets",  "Create default stylesheets?"],
  ["jquery",  "Replace Javascript defaults with jQuery?"],
  ["layouts",  "Create default layouts?"],
  ["gems",  "Install default gems?"],
  ["plugins",  "Install default plugins?"],
  ["authlogic",  "Add Authlogic-based authentication?"],
  ["hoptoad",  "Install HoptoadNotifier plugin?"],
  ["scout",  "Install Scout's Rails Instrumentation plugin?"],
  ["database",  "Create database?"],
  ["vhost",  "Create vhost?"]
]

@base_path = if template =~ %r{^(/|\w+://)}
  File.dirname(template)
else
  log '', "You used the app generator with a relative template path."
  ask "Please enter the full path or URL where the templates are located:"
end

@app_name = @root.split('/').last

# init git repo
git :init
 
def apply_template(t)
  tmpl = "#{@base_path}/#{t}.rb"
  log "applying", "template: #{tmpl}"
  load_template(tmpl)
  log "applied", tmpl
  # commit changes
  git :add => "."
  git :commit => "-a -m 'applied #{t} app template'"
end

# first template
apply_template('first')

# optional templates
optional_templates.each do |t, q|
  apply_template(t) if yes?(q)
end

# last template
apply_template('last')