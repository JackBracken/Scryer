# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  def self.all_cached
      Rails.cache.fetch("category_all", :expires_in => 6.hours) do
        all()
      end
    end
end
