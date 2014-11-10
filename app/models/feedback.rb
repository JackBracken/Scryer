class Feedback < ActiveRecord::Base
  belongs_to :user

  validates :feedback_text, presence: true
  validates :score, presence: true, inclusion: 1..10
end
