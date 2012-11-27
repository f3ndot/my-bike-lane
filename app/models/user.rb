class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :username
  validates_format_of :username, :without => /@/, :message => "cannot contain the '@' symbol"
  validates_uniqueness_of :username
  validates_length_of :username, :in => 2..25

  # Virtual attribute for allowing email or username for logging in
  attr_accessor :login

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
