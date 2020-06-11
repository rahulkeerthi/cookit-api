class RestaurantTag < ApplicationRecord
  belongs_to :restaurant
  belongs_to :tag
end
