class Announcement < ActiveRecord::Base
  attr_accessible :ends_at, :message, :starts_at
end
