class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates_presence_of :username
  validates_format_of :username, :without => /@/, :message => "cannot contain the '@' symbol"
  validates_uniqueness_of :username
  validates_length_of :username, :in => 2..25

  # Virtual attribute for allowing email or username for logging in
  attr_accessor :login
end
