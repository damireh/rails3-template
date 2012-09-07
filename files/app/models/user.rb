class User < ActiveRecord::Base
  extend FriendlyId

  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  attr_accessible :login, :username, :name, :email, :password, :password_confirmation, :remember_me, :avatar

  validates :name,     presence: true, length: { maximum: 50 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_attached_file :avatar
  friendly_id :username, use: :slugged

  # allow users to sign in using their username or email address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase }]).first
  end
end

