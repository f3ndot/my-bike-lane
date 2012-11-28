class Announcement < ActiveRecord::Base
  attr_accessible :ends_at, :message, :starts_at

  scope :current, -> { where("starts_at <= :now and ends_at >= :now", now: Time.zone.now) }

end
