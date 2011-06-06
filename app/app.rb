require 'rest-client'
require 'crack'
require 'yaml'
require 'growl'
require 'eventmachine'

@credentials = YAML.load_file(File.join('config','config.yml'))

# latest_global_status = Crack::XML.parse(RestClient.get(credentials['credentials']))['feed']['entry'].first
# unless latest_global_status['title'].include? 'stable'
#   Growl.notify_error("The build was broken #{Time.parse(latest_global_status['published']).strftime('at %I:%M %P on %m/%d/%Y')}", :sticky => true)
# end
def most_recent_non_aborted_status(i=0)
  feed = return_feed
  if i < feed.size - 1
    status = feed[i]
    if status['title'].include? 'aborted'
      i = i + 1
      most_recent_non_aborted_status(i)
    else
      return status
    end
  else
    return []
  end
end

def return_feed
  Crack::XML.parse(RestClient.get(@credentials['credentials']))['feed']['entry']
end

latest_global_status = nil
puts latest_global_status.inspect
EventMachine::run do
  EM.add_periodic_timer(3) do
    new_build = most_recent_non_aborted_status
    if latest_global_status != new_build
      if new_build['title'].include?('back to normal') || new_build['title'].include?('broken')
        Growl.notify_error("The build was broken #{Time.parse(new_build['published']).strftime('at %I:%M %P on %m/%d/%Y')}", :sticky => true)
      end
      latest_global_status = new_build
    end
  end
end



