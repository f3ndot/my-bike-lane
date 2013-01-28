class Violation < ActiveRecord::Base
  attr_accessible :address, :description, :title, :violator_id, :user_id, :photos_attributes, :slug, :license_plate, :flagged, :user_ip, :user_agent, :referrer, :spammed, :violator_attributes

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  self.per_page = 10

  # anti-spam measures
  include Rakismet::Model
  rakismet_attrs :content => :description
  # default_scope where(:spammed => false) # Breaks more than you think
  scope :only_spammed, lambda { where(:spammed => true) }
  scope :without_spammed, lambda { where(:spammed => false) }

  acts_as_voteable

  belongs_to :user
  belongs_to :violator
  has_many :photos, :dependent => :destroy

  accepts_nested_attributes_for :photos, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :violator, :reject_if => :all_blank, :allow_destroy => false

  validates_presence_of :title, :address

  def license_plate
    violator.try(:license)
  end

  def license_plate=(number)
    self.violator = Violator.find_or_create_by_license(number) if number.present?
  end
end
