# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
  def self.all_cached
    Rails.cache.fetch("language_all", :expires_in => 6.hours) do
      all()
    end
  end
end
