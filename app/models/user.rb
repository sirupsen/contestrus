require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :competitions, through: :participations
  has_many :submissions
  has_many :tasks, through: :submissions

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: true

  before_create :set_session_hash

  def invalidate_sessions!
    set_session_hash
    save!
  end

private
  def set_session_hash
    self.session_hash = SecureRandom.hex(8)
  end
end
