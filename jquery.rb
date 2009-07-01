git :rm => "public/javascripts/*"

file 'public/javascripts/jquery.js', 
  open('http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js').read

file "public/javascripts/application.js", <<-JS
$(function() {
  // ...
});
JS