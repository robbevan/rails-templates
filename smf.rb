# create smf
file "config/deploy/#{@app_name}.smf.xml",
%q{<?xml version='1.0'?>
<!DOCTYPE service_bundle SYSTEM '/usr/share/lib/xml/dtd/service_bundle.dtd.1'>
<service_bundle type='manifest' name='mongrel/APP_NAME-prod'>
  <service name='network/mongrel/APP_NAME-prod' type='service' version='0'>
    <create_default_instance enabled='true'/>
    <single_instance/>    
    <dependency name='fs' grouping='require_all' restart_on='none' type='service'>
      <service_fmri value='svc:/system/filesystem/local'/>
    </dependency>
    <dependency name='net' grouping='require_all' restart_on='none' type='service'>
      <service_fmri value='svc:/network/loopback'/>
    </dependency>
    <dependent name='mongrel_multi-user' restart_on='none' grouping='optional_all'>
      <service_fmri value='svc:/milestone/multi-user'/>
    </dependent>    
    <exec_method name='start' type='method' exec='/opt/local/bin/mongrel_rails cluster::start --clean' timeout_seconds='60'>
      <method_context working_directory='/path/to/domains/APP_NAME.tld/apps/APP_NAME/current/'>
        <method_credential user='USERNAME' group='staff'/>
        <method_environment>
          <envvar name="PATH" value="/usr/bin:/bin:/opt/local/bin" />
        </method_environment>
      </method_context>
    </exec_method>
    <exec_method name='stop' type='method' exec=':kill' timeout_seconds='60'>
      <method_context/>
    </exec_method>
  </service>
</service_bundle>}.gsub('APP_NAME', @app_name)

# append TODO
open('README.md', 'a') { |f|
  f.puts "Update .tld, paths and username etc. in 'config/deploy/#{@app_name}.smf.xml'"
}