# == Schema Information
#
# Table name: feedback
#
#  id            :integer          not null, primary key
#  feedback_text :text
#  score         :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Feedback < ActiveRecord::Base
  belongs_to :user

  validates :feedback_text, presence: true
  validates :score, presence: true, inclusion: 1..10

  after_save :notify_new_feedback

  protected

  def notify_new_feedback
    FeedbackMailer.new_feedback(self).deliver
  end
end
