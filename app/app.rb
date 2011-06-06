require 'rest-client'
require 'crack'
require 'yaml'
require 'growl'

credentials = YAML.load_file(File.join('config','config.yml'))
xml = RestClient.get(credentials['credentials'])
json = Crack::XML.parse(xml)

# json['feed']['entry'].each do |failed_build|
# end

failed_build = json['feed']['entry'].first
puts Date.parse(failed_build['published']).inspect
Growl.notify_error("The build was broken #{Time.parse(failed_build['published']).strftime('at %I:%M %P on %m/%d/%Y')}", :sticky => true)



