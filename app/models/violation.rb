class Violation < ActiveRecord::Base
  attr_accessible :address, :city, :latitude, :longitude, :description, :title, :datetime_of_incident, :violator_id, :user_id, :photos_attributes, :slug, :license_plate, :flagged, :user_ip, :user_agent, :referrer, :spammed, :violator_attributes

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  self.per_page = 10

  GTA_CITIES = %w(Toronto Markham Vaughan King Newmarket Aurora Richmond\ Hill Whitchurch-Stouffville East\ Gwillimbury Georgina Brock Uxbridge Scugog Pickering Ajax Whitby Oshawa Clarington Caledon Brampton Mississauga Oakville Milton Halton\ Hills Burlington).sort

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

  validates_presence_of :title, :address, :city

  def date_of_incident
    return nil if datetime_of_incident.nil?
    # default is "yyyy-mm-ddd"
    datetime_of_incident.to_date.strftime
  end

  def time_of_incident
    return nil if datetime_of_incident.nil?
    datetime_of_incident.to_time.strftime "%I:%M %p"
  end

  def date_of_incident=(date_str)
    @date = Date.parse date_str
    merge_date_and_time
  end

  def time_of_incident=(time_str)
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

  def merge_date_and_time
    if @date.present? and @time.present?
      datetime_of_incident = DateTime.parse "#{@date.to_s}, #{@time.strftime "%I:%M %p"}"
      raise datetime_of_incident.inspect
    end
  end
end
