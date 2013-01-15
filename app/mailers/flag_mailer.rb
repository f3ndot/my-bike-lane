class FlagMailer < ActionMailer::Base
  default from: "no-reply@mybikelane.to"

  def flag(violation, user)
    @violation = violation
    @user = user
    mail(:to => '"Justin Bull" <me@justinbull.ca>', :subject => "MyBikeLane Violation Flagged!")
  end
end
