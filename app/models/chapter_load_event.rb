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

class ChapterLoadEvent < PensieveEvent
  def self.from_params(current_user, request, params)
    event = ChapterLoadEvent.new
    ChapterLoadEvent.set_base_attributes(current_user, event, request, params)
    event.story_id = params['story']['id']
    event.story_name = params['story']['name']
    event.author_id = params['author']['id']
    event.author_name = params['author']['name']
    event.chapter_id = params['chapter']['id']
    event.chapter_name = params['chapter']['name']
    event.chapter_wordcount = params['chapter']['wordcount']
    event.page_load = Time.at(params['timestamp']/1000).utc.to_s(:db)

    event
  end
end
