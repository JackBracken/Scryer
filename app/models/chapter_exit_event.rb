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

    # extract story_id and chapter_id from url
    event.story_id, event.chapter_id = parse_ffn_uri(event.url)

    event
  end

  def timing
    load_raw_event

    @json['timing']
  end

  def scrolls
    load_raw_event

    @json['timing']
  end

  private

  def parse_ffn_uri(uri)
    story_id, chapter_id, name = uri.match(/fanfiction\.net\/s\/([0-9]+)\/([0-9]+)\/(.*)/).try(:captures)
    name.gsub!('-', ' ')

    return story_id, chapter_id, name
  end

  def load_raw_event
    @json ||= JSON.parse raw_event
  end
end
