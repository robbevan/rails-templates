options = [
  ["jquery",  "Use jQuery?"],
]

@base_path = if template =~ %r{^(/|\w+://)}
  File.dirname(template)
else
  log '', "You used the app generator with a relative template path."
  ask "Please enter the full path or URL where the templates are located:"
end

# default template
tmpl = "#{@base_path}/default.rb"
log "applying", "template: #{tmpl}"
load_template(tmpl)
log "applied", tmpl

# optional templates
options.each do |o, q|
  if yes?(q)
    tmpl = "#{@base_path}/#{o}.rb"
    log "applying", "template: #{tmpl}"
    load_template(tmpl)
    log "applied", tmpl
  end
end