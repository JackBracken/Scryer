# == Schema Information
#
# Table name: pensieve_events
#
#  id                :integer          not null, primary key
#  event_id          :integer
#  event_name        :string(255)
#  url               :string(255)
#  ip                :string(255)
#  user_agent        :string(255)
#  user_id           :integer
#  story_id          :integer
#  story_name        :string(255)
#  author_id         :integer
#  author_name       :string(255)
#  chapter_id        :integer
#  chapter_name      :integer
#  chapter_wordcount :integer
#  page_load         :datetime
#  page_start        :datetime
#  page_exit         :datetime
#  raw_event         :text
#  created_at        :datetime
#  updated_at        :datetime
#

class PensieveEvent < ActiveRecord::Base
  self.inheritance_column = 'event_name'

  def self.set_base_attributes(current_user, event, request, params)
    #event.event_name = params['event_name']
    event.event_id = params['event_id']
    event.url = params['url']
    event.ip = request.remote_ip
    event.user_id = current_user.try(:id) if current_user
    event.user_agent = request.user_agent
    event.raw_event = request.raw_post
  end
end
