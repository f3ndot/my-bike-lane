class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :admin, :username, :email, :password, :password_confirmation, :remember_me,
  :gender, :bio, :birthday, :given_name, :family_name, :hometown,
  :violations, :uid, :provider

  has_many :violations
  has_many :blog_posts
  has_many :photos

  acts_as_voter
  has_karma(:violations, :as => :user)

  validates_presence_of :username
  validates_format_of :username, :without => /@/, :message => "cannot contain the '@' symbol"
  validates_uniqueness_of :username
  validates_length_of :username, :in => 2..25
  validates_length_of :bio, :maximum => 500, :allow_nil => true
  validates_inclusion_of :gender, :in => %w(Male Female Other), :allow_nil => true

  scope :only_admins, lambda { where(:admin => true) }

  # Virtual attribute for allowing email or username for logging in
  attr_accessor :login

  def display_name(html = true)
    display = ""
    if html == true
      display << "<i class='icon-star'></i> " if admin?
    end
    if given_name.present? && family_name.present?
      display << "#{given_name} #{family_name}"
    else
      display << username
    end
    display.html_safe
  end

  def age
    return if birthday.nil?
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  # Twitter and Facebook login stuff
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.bio = auth.info.description

      name_parts = auth.info.name.split " "
      if name_parts.size > 0
        user.given_name = name_parts.first
        user.family_name = name_parts.last if name_parts.count > 1
      end
    end
  end

  # Overriding Devise's create with session for registration completion using Twitter or Facebook
  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # OmniAuth password bypass
  def password_required?
    super && provider.blank?
  end

  # Ignore blank passwords for OmniAuth accounts (FB or Twitter)
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  # Overriding Devise's method for auth
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
