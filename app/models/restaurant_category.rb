class RestaurantCategory < ApplicationRecord
  belongs_to :restaurant

  validates :name, presence: true, length: { minimum: 6 }

  # TODO: Add categories via seed
end
