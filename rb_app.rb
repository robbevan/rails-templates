optional_templates = [
  ["blueprint",  "Add Blueprint?"],
  ["stylesheets",  "Create default stylesheets?"],
  ["jquery",  "Add jQuery?"],
  ["authlogic",  "Add Authlogic?"],
  ["database",  "Create database?"]
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