class FeedbackMailer < ScryerMailerBase
  def new_feedback(feedback)
    @feedback = feedback
    mail(to: 'elementation@gmail.com', subject: prefixed('New feedback'))
  end
end
