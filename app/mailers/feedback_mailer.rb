class FeedbackMailer < ActionMailer::Base
  default from: 'feedback@collablearnapp.com'

  def feedback_email(feedback)
    @feedback = feedback
    mail(to: 'philipp.muens@googlemail.com', subject: 'New Feedback!')
  end
end