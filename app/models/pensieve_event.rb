class PensieveEvent < ActiveRecord::Base
  self.inheritance_column = 'event_name'

  def self.set_base_attributes(event, request, params)
    #event.event_name = params['event_name']
    event.event_id = params['event_id']
    event.url = params['url']
    event.ip = request.remote_ip
    #event.user_id = current_user.try(:id)
    event.user_agent = request.user_agent
    event.raw_event = params['collector'].to_json
  end
end
