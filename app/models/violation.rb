class Violation < ActiveRecord::Base
  attr_accessible :address, :description, :title, :violator_id, :user_id, :photos_attributes, :slug, :license_plate

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  belongs_to :user
  belongs_to :violator
  has_many :photos, :dependent => :destroy

  accepts_nested_attributes_for :photos, :allow_destroy => true

  validates_presence_of :title, :address

  def license_plate
    violator.try(:license)
  end

  def license_plate=(number)
    self.violator = Violator.find_or_create_by_license(number) if number.present?
  end
end
