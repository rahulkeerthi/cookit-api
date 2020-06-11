class Tag < ApplicationRecord
  has_many :restaurant_tags
  has_many :restaurants, through: :restaurant_tags
  has_many :kit_tags
  has_many :kits, through: :kit_tags

  validates :name, presence: true, length: { minimum: 6 }
end
