# keep empty dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")
 
# rake('db:migrate')

# rake("gems:install", :sudo => true)
# rake("gems:unpack")

# Initialize submodules
# git :submodule => "init"