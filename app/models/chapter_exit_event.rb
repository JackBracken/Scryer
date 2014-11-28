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

class ChapterExitEvent < PensieveEvent
  def self.from_params(current_user, request, params)
    event = ChapterExitEvent.new
    ChapterExitEvent.set_base_attributes(current_user, event, request, params)
    event.page_start = Time.at(params['timing']['interact_start']/1000).utc.to_s(:db)
    event.page_exit = Time.at(params['timing']['end']/1000).utc.to_s(:db)

    event
  end
end
