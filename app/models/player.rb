class Player < ApplicationRecord
  has_many :statistics
  
  validates :name, presence: true
  validates :given_name, presence: true
  validates :position, presence: true
end
