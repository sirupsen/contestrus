class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :competitions, through: :participations
  has_many :submissions

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
