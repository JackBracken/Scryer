class PageExitEvent < PensieveEvent
  def self.from_params(request, params)
    event = PageExitEvent.new
    PageExitEvent.set_base_attributes(event, request, params)
    event.page_start = Time.at(params['timing']['interact_start']/1000).utc.to_s(:db)
    event.page_exit = Time.at(params['timing']['end']/1000).utc.to_s(:db)

    event
  end
end
