class SubscriptionMailer < ActionMailer::Base
  default from: "no-reply@mybikelane.to"

  def notify(subscriber, violation)
    @violation = violation
    @subscriber = subscriber
    mail(:to => subscriber.email, :subject => "MyBikeLane.TO Violation Notification")
  end
end
