class ScryerMailerBase < ActionMailer::Base
  default from: 'scryer@darklordpotter.net'

  protected

  def prefixed(subject)
    "[Scryer] #{subject}"
  end
end
