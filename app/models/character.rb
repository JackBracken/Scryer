class Character < ActiveRecord::Base
  def self.for_fandoms(fandoms)
    if fandoms && fandoms.size > 1
      self.fandom_union(fandoms).collect do |c|
        c = Character.new(id: c.character_id, name:c.name, fandom_id: c.fandom_id)
        c.readonly!
        c
      end
    else
      where(:fandom_id => 224)
    end
  end

  def self.fandom_union(fandoms)
    # Stable cache keys
    fandoms = fandoms.sort

    Rails.cache.fetch("fandom_character_union_#{fandoms}", :expires_in => 24.hours) do
      $scryer.union_characters(fandoms)
    end
  end
end
