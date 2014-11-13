class CollectorController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive_event
    if is_page_load?
      PageLoadEvent.from_params(request, params).save!
    else
      PageExitEvent.from_params(request, params).save!
    end

    head 200, content_type: 'application/json'
  end

  private

  def is_page_load?
    params['event_name'] == 'page_load'
  end
end
