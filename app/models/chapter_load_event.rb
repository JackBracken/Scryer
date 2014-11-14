class ChapterLoadEvent < PensieveEvent
  def self.from_params(request, params)
    event = ChapterLoadEvent.new
    ChapterLoadEvent.set_base_attributes(event, request, params)
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
