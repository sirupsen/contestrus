class Language < ActiveRecord::Base
  validates :name, presence: true
  validates :extension, presence: true
  validates :image, presence: true
  validates :build, presence: true
  validates :run, presence: true
end
