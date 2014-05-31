class Violation < ActiveRecord::Base
  attr_accessible :address, :city, :latitude, :longitude, :description, :title, :datetime_of_incident, :violator_id, :user_id, :photos_attributes, :slug, :license_plate, :flagged, :user_ip, :user_agent, :referrer, :spammed, :violator_attributes, :date_of_incident, :time_of_incident

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  GTA_CITIES = %w(Toronto Markham Vaughan King Newmarket Aurora Richmond\ Hill Whitchurch-Stouffville East\ Gwillimbury Georgina Brock Uxbridge Scugog Pickering Ajax Whitby Oshawa Clarington Caledon Brampton Mississauga Oakville Milton Halton\ Hills Burlington).sort

  # anti-spam measures
  include Rakismet::Model
  rakismet_attrs :content => :description
  # default_scope where(:spammed => false) # Breaks more than you think
  scope :only_spammed, lambda { where(:spammed => true) }
  scope :without_spammed, lambda { where(:spammed => false) }

  # a custom version of plusminus_tally so it can play well with Kaminari or will_paginate
  scope :by_score, joins("LEFT OUTER JOIN votes ON violations.id = votes.voteable_id AND votes.voteable_type = 'Violation'").
                   group("violations.id").
                   order("SUM(CASE votes.vote WHEN 't' THEN 1 WHEN 'f' THEN -1 ELSE 0 END) DESC")

  acts_as_voteable

  belongs_to :user
  belongs_to :violator, :counter_cache => true
  has_many :photos, :dependent => :destroy

  accepts_nested_attributes_for :photos, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :violator, :reject_if => :all_blank, :allow_destroy => false

  validates_presence_of :title, :address, :city

  # Fixes the counter_cache in a has_many through relationship
  after_create :increment_organization_counter_cache
  after_destroy :decrement_organization_counter_cache

  def date_of_incident
    return '' if datetime_of_incident.blank?
    # default is "yyyy-mm-ddd"
    datetime_of_incident.to_date.strftime
  end

  def time_of_incident
    return '' if datetime_of_incident.blank?
    datetime_of_incident.to_time.strftime "%I:%M %p"
  end

  def date_of_incident=(date_str)
    return '' if date_str.blank?
    @date = Date.parse date_str
    merge_date_and_time
  end

  def time_of_incident=(time_str)
    return '' if time_str.blank?
    @time = Time.parse time_str
    merge_date_and_time
  end

  def full_address
    GTA_CITIES.include?(city) ? "#{address}, #{city}" : address
  end

  def license_plate
    violator.try(:license)
  end

  def license_plate=(number)
    self.violator = Violator.find_or_initialize_by_license(number) if number.present?
  end

  private

  def increment_organization_counter_cache
    if self.violator.present? && self.violator.organization.present?
      Organization.increment_counter 'violations_count', self.violator.organization.id
    end
  end

  def decrement_organization_counter_cache
    if self.violator.present? && self.violator.organization.present?
      Organization.decrement_counter 'violations_count', self.violator.organization.id
    end
  end

  def merge_date_and_time
    if @date.present?
      if @time.present?
        self.datetime_of_incident = DateTime.parse "#{@date.to_s}, #{@time.strftime "%I:%M %p"}"
      else
        self.datetime_of_incident = DateTime.parse "#{@date.to_s}"
      end
    end
  end
end
