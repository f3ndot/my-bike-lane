class FeedbackMailer < ActionMailer::Base
  default from: "no-reply@mybikelane.to"

  def feedback(message, user)
    @message = message
    @user = user
    mail(:to => '"Justin Bull" <me@justinbull.ca>', :subject => "MyBikeLane Feedback!")
  end
end
