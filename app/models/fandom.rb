require 'hashie/mash'

class Fandom < ActiveRecord::Base
  has_many :characters

  self.def fandom_facets(fandom_id)
    Rails.cache.fetch("fandom_facets_#{fandom_id}", :expires_in => 6.hours) do
      buckets = $elasticsearch.search(
          index: 'ffncrossover_index',
          body: {
            aggregations: {
              fandoms: {
                filter: { term: { 'fandoms.fandom_id' => fandom_id }},
                aggregations: {
                  fandoms: {
                    terms: {
                      field: 'fandoms.fandom_id',
                      size: 0
                    }
                  }
                }
              }
            }
          })['aggregations']['fandoms']['fandoms']['buckets']

      fandom_sizes = buckets.inject({}) do |r,a|
        r[a['key']] = a['doc_count']
        r
      end

      Fandom.all.map do |f|
        story_count = fandom_sizes[f.id] || 0
        { id: f.id, name: f.name + " (#{story_count})", stories: story_count }
      end.sort_by do |f|
        f[:stories]
      end.reverse.find_all do |f|
        f[:id] != fandom_id # remove the current fandom from the list
      end.map do |f|
        Hashie::Mash.new f
      end
    end
  rescue e
    Fandom.all.order(:name)
  end
end
