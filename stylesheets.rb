file "public/stylesheets/application.css",
%q{@import 'screen.css';
@import 'print.css';}

file "public/stylesheets/admin/application.css",
%q{@import '../screen.css';
@import 'screen.css';
@import '../print.css';}

file "public/stylesheets/ie.css", ''
file "public/stylesheets/print.css", ''
file "public/stylesheets/screen.css", open("#{@base_path}/screen.css").read
file "public/stylesheets/admin/screen.css", ''