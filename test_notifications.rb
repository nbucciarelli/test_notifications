require 'rubygems'
require 'yaml'
require 'daemons'

@@credentials = YAML.load_file(File.join('./config','config.yml'))
Daemons.run('./app/app.rb')