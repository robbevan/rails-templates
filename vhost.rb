# create vhost
file "config/deploy/#{@app_name}.tld.conf",
%q{<VirtualHost *:80>
ServerName APP_NAME.tld
ServerAlias www.APP_NAME.tld
DocumentRoot /path/to/APP_NAME/apps/APP_NAME/current/public
<Directory "/path/to/APP_NAME/apps/APP_NAME/current/public/">
Options FollowSymLinks
AllowOverride None
Order allow,deny
Allow from all
</Directory>
RewriteEngine On
RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f
RewriteRule ^/(.*)$ balancer://APP_NAME-mongrels%{REQUEST_URI} [P,QSA,L]
<Proxy balancer://APP_NAME-mongrels>
BalancerMember http://127.0.0.1:8000
BalancerMember http://127.0.0.1:8001
</Proxy>
ProxyPass /images !
ProxyPass /stylesheets !
ProxyPass /javascripts !
ProxyPass / balancer://APP_NAME-mongrels
ProxyPassReverse / balancer://APP_NAME-mongrels
ProxyPreserveHost On
</VirtualHost>}.gsub('APP_NAME', @app_name)

# append TODO
open('README.md', 'a') { |f|
  f.puts "Update .tld and paths etc. in 'config/deploy/#{@app_name}.tld' (file name and contents)"
}
