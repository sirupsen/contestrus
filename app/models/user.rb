class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :competitions, through: :participations

  validates :username, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
