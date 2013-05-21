class Subscription < ActiveRecord::Base
  attr_accessible :active, :email, :notification_type, :user, :user_id
  belongs_to :user

  NOTIFICATION_TYPES = [:violation, :weekly, :monthly]

  validates_presence_of :notification_type, :message => "You must choose a subscription type"
  validates_presence_of :email, :if => lambda { user.blank? }, :message => "Email required if no user is selected"
  validates_presence_of :user, :if => lambda { email.blank? }, :message => "Can't be blank or choose email instead"

  scope :type, lambda { |type| where(:notification_type => type) }

  def email
    return user.email if self.user.present?
    read_attribute(:email)
  end
end
